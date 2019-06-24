insert into Customer values(1, 0019920201, 'M1', 'F1', 'PASS1');
insert into Customer values(2, 0019920202, 'M2', 'F2', 'PASS2');
insert into Customer values(3, 0019920203, 'M3', 'F3', 'PASS3');
insert into Customer values(4, 0019920204, 'M4', 'F4', 'PASS4');
insert into Customer values(5, 0019920205, 'M5', 'F5', 'PASS5');
insert into Customer values(6, 0019920206, 'M6', 'F6', 'PASS6');




insert into Address values(1, 'Address 1-1');
insert into Address values(1, 'Address 1-2');
insert into Address values(1, 'Address 1-3');
insert into Address values(2, 'Address 2-1');
insert into Address values(3, 'Address 3-1');
insert into Address values(4, 'Address 4-1');
insert into Address values(5, 'Address 5-1');
insert into Address values(6, 'Address 6-1');
insert into Address values(6, 'Address 6-2');




insert into Phone values(1, 'Phone 1-1');
insert into Phone values(1, 'Phone 1-2');
insert into Phone values(2, 'Phone 2-1');
insert into Phone values(3, 'Phone 3-1');
insert into Phone values(4, 'Phone 4-1');
insert into Phone values(4, 'Phone 4-2');
insert into Phone values(4, 'Phone 4-3');
insert into Phone values(5, 'Phone 5-1');
insert into Phone values(6, 'Phone 6-1');

select * from Phone;
select * from Phone_deletion_backup;
delete from Phone where customerNumber = 6;
select * from Phone_deletion_backup;



insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(1, 1000, 'current', 1);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(2, 1000, 'charity', 3);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(3, 2000, 'saving', 2);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(4, 2000, 'current', 5);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(5, 3000, 'charity', 1);
insert into Accounts(accountNumber, balance, accountType, NoSignatures) values(6, 4000, 'saving', 2);



insert into Role values(1, 1, 'owner');
insert into Role values(1, 1, 'view');
insert into Role values(1, 1, 'pay');
insert into Role values(1, 1, 'sign');
insert into Role values(1, 2, 'sign');

insert into Role values(2, 2, 'owner');
insert into Role values(2, 3, 'owner');
insert into Role values(2, 2, 'view');
insert into Role values(2, 3, 'pay');
insert into Role values(2, 1, 'sign');
insert into Role values(2, 2, 'sign');
insert into Role values(2, 3, 'sign');
insert into Role values(2, 4, 'sign');

insert into Role values(3, 3, 'owner');
insert into Role values(3, 5, 'sign');
insert into Role values(3, 4, 'sign');

insert into Role values(4, 4, 'owner');
insert into Role values(4, 4, 'sign');

insert into Role values(5, 5, 'owner');
insert into Role values(5, 5, 'sign');
insert into Role values(5, 4, 'owner');
insert into Role values(5, 3, 'owner');
insert into Role values(5, 1, 'view');
insert into Role values(5, 2, 'pay');
insert into Role values(5, 3, 'pay');


insert into Role values(6, 6, 'owner');
insert into Role values(6, 6, 'sign');


select * from accessLogs;

delete from Role
where (accountNumber, customerNumber, role) = (5, 3, 'pay');

select * from accessLogs;



insert into Payment(paymentNumber, note, creatorNumber, sourceAccountNumber) values(1001, 'note 1001', 2, 1);

select * from Payment;
insert into Transactions values(1001, 3, 100);
select * from Payment;
insert into Transactions values(1001, 4, 150);
select * from Payment;
update Transactions set amount = 200 where (paymentNumber, destinationAccountNumber) = (1001, 3);
select * from Payment;


insert into Signatures values(1, 1001); -- possible
delete from Signatures where (customerNumber, paymentNumber) = (1, 1001); -- possible
update Payment Set state = 1 where paymentNumber = 1001; -- not enough signatures
insert into Signatures values(1, 1001); -- possible
insert into Signatures values(5, 1001); -- impossible
insert into Signatures values(2, 1001); -- possible
select * from Bill;
update Payment Set state = 1 where paymentNumber = 1001; -- ok
select * from Bill;
select * from Accounts;
delete from Signatures where (customerNumber, paymentNumber) = (1, 1001); -- impossible payment is done




insert into Payment(paymentNumber, note, creatorNumber, sourceAccountNumber) values(1002, 'note 1002', 3, 2);

update Payment set creatorNumber = 4 where paymentNumber = 1002; -- ok
insert into Signatures values(1, 1002);
update Payment set creatorNumber = 3 where paymentNumber = 1002; -- impossible! it has one signatues

delete from Signatures where(customerNumber, paymentNumber) = (1, 1002); -- foreign key to payment
delete from Payment where paymentNumber = 1002; -- ok

select * from accountslogs;

call tables_info('Payment');