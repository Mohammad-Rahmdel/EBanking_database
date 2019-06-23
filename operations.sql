-- Q1
insert into Customer values(61, 0019920261, 'James', 'Bond', 'PASS1123');
insert into Customer values(62, 0019920262, 'Drake', 'Ramoray', 'PASS1eggg');
insert into Customer values(63, 0019920263, 'Coral', 'Simanovich', 'PASSdddd1');


-- Q2
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(11, 1200, 'currnet', 2);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(12, 3300, 'charity', 3);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(13, 1049, 'saving', 2);


-- Q3
-- accountNumber, customerNumber, role
insert into Role values(11, 61, 'sign');
insert into Role values(11, 62, 'pay');
insert into Role values(12, 62, 'sign');
insert into Role values(12, 63, 'view');
insert into Role values(13, 61, 'view');
insert into Role values(13, 63, 'pay');

delete from Role where (accountNumber, customerNumber, role) = (13, 63, 'pay');

update Role set role = 'pay'
where (accountNumber, customerNumber) = (13, 61);


-- Q4
insert into Payment(paymentNumber, note, creatorNumber, sourceAccountNumber) 
values(1021, 'note 1021', 61, 11);


-- Q5
update Payment set sourceAccountNumber = 12
where paymentNumber = 1021;

delete from Payment
where paymentNumber = 1021;


-- Q6
insert into Payment(paymentNumber, note, creatorNumber, sourceAccountNumber) 
values(1021, 'note 1021', 61, 11);

insert into Signatures values(63, 1021); -- impossible [user=63 accountnumber=11]
insert into Signatures values(61, 1021); -- possible

delete from Signatures 
where (customerNumber, paymentNumber) = (61, 1021);


-- Q7
insert into Transactions values(1021, 12, 300);
insert into Transactions values(1021, 13, 450);

delete from Transactions
where (paymentNumber, destinationAccountNumber) = (1021, 13);

update Transactions set amount = 333
where (paymentNumber, destinationAccountNumber) = (1021, 12);


-- Q8
insert into Role values(11, 62, 'sign');
insert into Role values(11, 63, 'sign');
update Payment set state = 1 where paymentNumber = 1021; -- impossible 1 < 2 
insert into Signatures values(63, 1021);
update Payment set state = 1 where paymentNumber = 1021; -- possible 2 => 2 



-- Q9
/* 
This operation is fully automatic using triggers.
*/

insert into Bill(eventTime, fund, AccountNumber, description, billType) 
values (current_timestamp(), 11500, 11, 'example1', 'receive');

insert into Bill(eventTime, fund, AccountNumber, description, billType) 
values (current_timestamp(), 24600, 12, 'example2', 'send');