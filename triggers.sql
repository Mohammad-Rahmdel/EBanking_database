-- use mysql; 
-- CREATE DATABASE test; 
-- use test; 

DELIMITER $$
create trigger grant_access_log after insert on Role
	for each row 
	begin
		insert into accessLogs values(new.customerNumber, new.role, current_timestamp(), 'grant');
	end$$
DELIMITER ;




DELIMITER $$
create trigger revoke_access_log after delete on Role
	for each row 
	begin
		insert into accessLogs values(old.customerNumber, old.role, current_timestamp(), 'revoke');
	end$$
DELIMITER ;





DELIMITER $$
create trigger Transactions_backup after delete on Transactions
	for each row 
	begin
		insert into Transactions_deletion_backup values(old.paymentNumber, old.destinationAccountNumber, old.amount);
	end$$
DELIMITER ;


    
DELIMITER $$
create trigger Payment_backup after delete on Payment
	for each row 
	begin
		insert into Payment_deletion_backup values(old.paymentNumber, old.note, old.creatorNumber, old.sourceAccountNumber, old.total, old.state);
	end$$
DELIMITER ;


   
DELIMITER $$
create trigger Bill_backup after delete on Bill
	for each row 
	begin
		insert into Bill_deletion_backup values(old.eventTime, old.fund, old.description, old.billType);
	end$$
DELIMITER ;


DELIMITER $$
create trigger Role_backup after delete on Role
	for each row 
	begin
		insert into Role_deletion_backup values(old.accountNumber, old.customerNumber, old.role);
	end$$
DELIMITER ;


	
DELIMITER $$
create trigger Accounts_backup after delete on Accounts
	for each row 
	begin
		insert into Accounts_deletion_backup values(old.accountNumber, old.balance, old.accountType, old.NoSignatures, old.accountColor, old.accountName);
	end$$
DELIMITER ;



DELIMITER $$
create trigger Address_backup after delete on Address
	for each row 
	begin
		insert into Address_deletion_backup values(old.customerNumber, old.Address);
	end$$
DELIMITER ;


DELIMITER $$
create trigger Phone_backup after delete on Phone
	for each row 
	begin
		insert into Phone_deletion_backup values(old.customerNumber, old.phoneNumber);
	end$$
DELIMITER ;



DELIMITER $$
create trigger Customer_backup after delete on Customer
	for each row 
	begin
		insert into Customer_deletion_backup values(old.customerNumber, old.id, old.nam, old.familyname, old.pass);
	end$$
DELIMITER ;


DELIMITER $$
create trigger Signatures_backup after delete on Signatures
	for each row 
	begin
		insert into Signatures_deletion_backup values(old.customerNumber, old.paymentNumber);
	end$$
DELIMITER ;



DELIMITER $$
create trigger Payment_updator_add after insert on Transactions
	for each row 
	begin
		 update Payment 
         set total = total + new.amount 
         where Payment.paymentNumber = NEW.paymentNumber ;
	end$$
DELIMITER ;



DELIMITER $$
create trigger Payment_updator_remove after delete on Transactions
	for each row 
	begin
		 update Payment 
         set total = total - old.amount 
         where Payment.paymentNumber = old.paymentNumber ;
	end$$
DELIMITER ;



DELIMITER $$
create trigger Payment_updator_edit after update on Transactions
	for each row 
	begin
		 update Payment 
         set total = total - old.amount + new.amount
         where Payment.paymentNumber = old.paymentNumber ;
	end$$
DELIMITER ;




DELIMITER $$
create trigger Payment_edit_checker before update on Payment
	for each row 
	begin
		 IF exists (
         select *
         from Signatures natural join Payment
         where paymentNumber = old.paymentNumber)
			 THEN BEGIN
				
                IF (old.note<>new.note or old.creatorNumber<>new.creatorNumber or old.sourceAccountNumber<>
                new.sourceAccountNumber) THEN BEGIN
					SIGNAL sqlstate '45001' set message_text = "Payment edition is not allowed";
				END;
                END IF;
		 END;
         END IF;
	end$$
DELIMITER ;


DELIMITER $$
create trigger Sign_authority_checker before insert on Signatures
	for each row begin
		IF new.customerNumber not in (
			select customerNumber from Payment P inner join Role R on P.sourceAccountNumber = R.accountNumber 
			where role='sign' and P.paymentNumber = new.paymentNumber
		)
			THEN BEGIN
				SIGNAL sqlstate '45001' set message_text = "You cannot Sign this payment";
			END;
		END IF;
	END$$
DELIMITER ;



DELIMITER $$
create trigger Sign_canceling_checker before delete on Signatures
	FOR EACH ROW BEGIN
    IF old.paymentNumber in (
		select paymentNumber from Payment where state = 1)
        THEN BEGIN
			SIGNAL sqlstate '45001' set message_text = "Cancel Sign Not Allowed";
		END;
	else
		begin
			DECLARE accountNo INT;
			SET accountNo = (select sourceAccountNumber from Signatures natural join Payment 
			where paymentNumber=old.paymentNumber and customerNumber=old.customerNumber);
			insert into accountslogs values(accountNo , 'remove sign', current_timestamp);
        end;
	END IF;
    END$$
DELIMITER ;






DELIMITER $$
create trigger Payment_Confirmation_Checker before update on Payment
	FOR EACH ROW BEGIN
    IF NEW.state = 1 and (select count(*) from Signatures natural join Payment where paymentNumber=NEW.paymentNumber) <
			(select NoSignatures from Payment P inner join Accounts A on A.accountNumber=P.sourceAccountNumber where P.paymentNumber = NEW.paymentNumber)
	THEN
    BEGIN
		SIGNAL sqlstate '45001' set message_text = "NOT ENOUGH SIGNATURES";
	END;
    END IF;
--     
    
    IF Old.state = 0 and New.state =1 THEN BEGIN
    IF
    (New.total > (select balance from Accounts A inner join Payment P 
    where A.accountNumber=P.sourceAccountNumber and P.paymentNumber = New.paymentNumber))
	THEN
    BEGIN
		SIGNAL sqlstate '45001' set message_text = "NOT ENOUGH Fund";
	END;
    END IF;
    
    end;
    end if;
    
    END$$
DELIMITER ;



DELIMITER $$
create trigger Payment_Confirmation_Results after update on Payment

	FOR EACH ROW BEGIN
    
    DECLARE j INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
    
    DECLARE accountNo INT;
    DECLARE accountAmount FLOAT;

    
	IF Old.state = 0 and New.state = 1 THEN BEGIN
    
		insert into accountslogs values(old.sourceAccountNumber , 'payment', current_timestamp);
    
		update Accounts 
		set balance = balance - new.total 
		where accountNumber = NEW.sourceAccountNumber ;
	
    
        insert into Bill(eventTime, fund, AccountNumber, description, billType)  values(curdate(), new.total, NEW.sourceAccountNumber, 'description', 'send'); 
    
    
        SET j = (
        select count(*) from Payment natural join Transactions
        where paymentNumber = NEW.paymentNumber);
        
        WHILE i < j DO
			INSERT INTO Bill(eventTime, fund, AccountNumber, description, billType) 
			SELECT current_timestamp(), sub.amount, sub.dAN, 'description', 'receieve'
            FROM (select amount, destinationAccountNumber dAN from Payment natural join Transactions
			where paymentNumber = NEW.paymentNumber) as sub
			LIMIT i,1;
            
			SET i = i + 1;
        END WHILE;
    
    
    
        SET i = 0;
        
        WHILE i < j DO
			select destinationAccountNumber into accountNo
            from Payment natural join Transactions 
			where New.paymentNumber = Payment.paymentNumber
            LIMIT i,1;
            
            select amount into accountAmount
            from Payment natural join Transactions 
			where New.paymentNumber = Payment.paymentNumber
            LIMIT i,1;
        
			update Accounts 
            set balance = balance + accountAmount
            where accountNumber = accountNo;
		
            SET i = i + 1;
        END WHILE;
        
    END; END IF;
END$$
DELIMITER ;




DELIMITER $$
create trigger accountlog_creation after insert on Accounts
FOR EACH ROW BEGIN
	insert into accountslogs values(new.accountNumber , 'creation', current_timestamp);
END$$
DELIMITER ;



DELIMITER $$
create trigger accountlog_add_sign after insert on Signatures
FOR EACH ROW BEGIN
	DECLARE accountNo INT;
    SET accountNo = (select sourceAccountNumber from Signatures natural join Payment 
    where paymentNumber=new.paymentNumber and customerNumber=new.customerNumber);
    
	insert into accountslogs values(accountNo , 'add sign', current_timestamp);
END$$
DELIMITER ;


