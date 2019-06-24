delimiter $$
CREATE PROCEDURE transactions_list(accountNumber int)
    begin
		SELECT * 
        FROM Transactions natural JOIN Payment
		WHERE destinationAccountNumber = accountNumber and state = 0;  
    end $$
DELIMITER ;


delimiter $$
CREATE PROCEDURE deleted_signs_list(customerNo int)
    begin
		select * 
		from Signatures_deletion_backup
		where customerNumber = customerNo;
    end $$
DELIMITER ;


delimiter $$
CREATE PROCEDURE sharing_accounts(customerNo1 int, customerNo2 int)
    begin
		select a1 as account_number from (
			select distinct accountNumber as a1
			from Role
			where customerNumber = customerNo1) sub1
			inner join (
			select distinct accountNumber as a2
			from Role
			where customerNumber = customerNo2) sub2
			where a1 = a2;
    end $$
DELIMITER ;
	


delimiter $$
CREATE PROCEDURE payments_list(customerNo int)
begin
	select paymentNumber, note, creatorNumber, sourceAccountNumber, total, state
from Role inner join Payment
on accountNumber = sourceAccountNumber
where role = 'sign' and customerNumber = customerNo;
end $$
DELIMITER ;


delimiter $$
CREATE PROCEDURE specific_payments_list(customerNo int)
begin
	select distinct paymentNumber
	from Payment natural join Transactions
	where creatorNumber = customerNo
	not in(
	select paymentNumber
	from Payment inner join Role
	on sourceAccountNumber = accountNumber
	where role = 'sign' and customerNumber = customerNo);
end $$
DELIMITER ;



delimiter $$
CREATE PROCEDURE specific_transactions_list(AccountNo int, amountt float)
begin
	select *
	from Transactions natural join Payment
	where state=1 and destinationAccountNumber = AccountNo and amount > amountt;
end $$
DELIMITER ;


delimiter $$
CREATE PROCEDURE tables_info(tableName varchar(32))
	begin
	SELECT CREATE_TIME, UPDATE_TIME
	FROM INFORMATION_SCHEMA.TABLES
    WHERE table_name = tableName;
end $$
DELIMITER ;



create view customers_with_sign_authority as
	select distinct customerNumber
	from Signatures;


create view ready_payments as 
	select accountNumber, NoSignatures, count(*) as signs
	from Role natural join
	(select NoSignatures, accountNumber
	from Payment P inner join Accounts A 
	on A.accountNumber=P.sourceAccountNumber) sub
	where role = 'sign'
	group by accountNumber, NoSignatures
	having NoSignatures <= signs;




