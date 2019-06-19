use mysql;

drop table Transactions;
drop table Payment;
drop table Role;
drop table Accounts;
drop table Phone;
drop table Address;
drop table Customer;


Create Table Customer(
    customerNumber int,
    id int,
	nam varchar(32),
    familyname varchar(32),
    pass varchar(32),
    primary key(customerNumber)
);


insert into Customer values(1, 0019920201, 'M1', 'F1', 'PASS1');
insert into Customer values(2, 0019920202, 'M2', 'F2', 'PASS2');
insert into Customer values(3, 0019920203, 'M3', 'F3', 'PASS3');
insert into Customer values(4, 0019920204, 'M4', 'F4', 'PASS4');
insert into Customer values(5, 0019920205, 'M5', 'F5', 'PASS5');
insert into Customer values(6, 0019920206, 'M6', 'F6', 'PASS6');
insert into Customer values(7, 0019920207, 'M7', 'F7', 'PASS7');
insert into Customer values(8, 0019920208, 'M8', 'F8', 'PASS8');
insert into Customer values(9, 0019920209, 'M9', 'F9', 'PASS9');
insert into Customer values(10, 0019920210, 'M10', 'F10', 'PASS10');
insert into Customer values(11, 0019920211, 'M11', 'F11', 'PASS11');
insert into Customer values(12, 0019920212, 'M12', 'F12', 'PASS12');
insert into Customer values(13, 0019920213, 'M13', 'F13', 'PASS13');
insert into Customer values(14, 0019920214, 'M14', 'F14', 'PASS14');
insert into Customer values(15, 0019920215, 'M15', 'F15', 'PASS15');
insert into Customer values(16, 0019920216, 'M16', 'F16', 'PASS16');
insert into Customer values(17, 0019920217, 'M17', 'F17', 'PASS17');
insert into Customer values(18, 0019920218, 'M18', 'F18', 'PASS18');
insert into Customer values(19, 0019920219, 'M19', 'F19', 'PASS19');
insert into Customer values(20, 0019920220, 'M20', 'F20', 'PASS20');
insert into Customer values(21, 0019920221, 'M21', 'F21', 'PASS21');
insert into Customer values(22, 0019920222, 'M22', 'F22', 'PASS22');
insert into Customer values(23, 0019920223, 'M23', 'F23', 'PASS23');
insert into Customer values(24, 0019920224, 'M24', 'F24', 'PASS24');
insert into Customer values(25, 0019920225, 'M25', 'F25', 'PASS25');
insert into Customer values(26, 0019920226, 'M26', 'F26', 'PASS26');
insert into Customer values(27, 0019920227, 'M27', 'F27', 'PASS27');
insert into Customer values(28, 0019920228, 'M28', 'F28', 'PASS28');
insert into Customer values(29, 0019920229, 'M29', 'F29', 'PASS29');
insert into Customer values(30, 0019920230, 'M30', 'F30', 'PASS30');



Create table Address(
	customerNumber int,
    Address varchar(128),
    primary key(customerNumber, Address),
    foreign key(customerNumber) references Customer(customerNumber)
);


insert into Address values(1, 'Address1-1');
insert into Address values(1, 'Address1-2');
insert into Address values(1, 'Address1-3');
insert into Address values(2, 'Address2-1');
insert into Address values(3, 'Address3-1');
insert into Address values(4, 'Address4-1');
insert into Address values(5, 'Address5-1');
insert into Address values(6, 'Address6-1');
insert into Address values(7, 'Address7-1');
insert into Address values(8, 'Address8-1');
insert into Address values(9, 'Address9-1');
insert into Address values(9, 'Address9-2');
insert into Address values(10, 'Address10-1');
insert into Address values(10, 'Address10-2');
insert into Address values(10, 'Address10-3');
insert into Address values(11, 'Address11-1');
insert into Address values(12, 'Address12-1');
insert into Address values(13, 'Address13-1');
insert into Address values(14, 'Address14-1');
insert into Address values(15, 'Address15-1');
insert into Address values(16, 'Address16-1');
insert into Address values(16, 'Address16-2');
insert into Address values(17, 'Address17-1');
insert into Address values(18, 'Address18-1');
insert into Address values(19, 'Address19-1');
insert into Address values(20, 'Address20-2');
insert into Address values(20, 'Address20-3');
insert into Address values(20, 'Address20-4');
insert into Address values(20, 'Address20-5');
insert into Address values(21, 'Address21-1');
insert into Address values(22, 'Address22-1');
insert into Address values(23, 'Address23-1');
insert into Address values(24, 'Address24-1');
insert into Address values(25, 'Address25-1');
insert into Address values(26, 'Address26-1');
insert into Address values(27, 'Address27-1');
insert into Address values(28, 'Address28-1');
insert into Address values(29, 'Address29-1');
insert into Address values(30, 'Address30-1');


Create table Phone(
	customerNumber int,
    phoneNumber varchar(128),
    primary key(customerNumber, phoneNumber),
    foreign key(customerNumber) references Customer(customerNumber)
);

insert into Phone values(1, 'Phone1-1');
insert into Phone values(1, 'Phone1-2');
insert into Phone values(2, 'Phone2-1');
insert into Phone values(3, 'Phone3-1');
insert into Phone values(4, 'Phone4-1');
insert into Phone values(4, 'Phone4-2');
insert into Phone values(4, 'Phone4-3');
insert into Phone values(5, 'Phone5-1');
insert into Phone values(6, 'Phone6-1');
insert into Phone values(7, 'Phone7-1');
insert into Phone values(8, 'Phone8-1');
insert into Phone values(9, 'Phone9-1');
insert into Phone values(9, 'Phone9-2');
insert into Phone values(10, 'Phone10-1');
insert into Phone values(10, 'Phone10-2');
insert into Phone values(10, 'Phone10-3');
insert into Phone values(11, 'Phone11-1');
insert into Phone values(12, 'Phone12-1');
insert into Phone values(13, 'Phone13-1');
insert into Phone values(13, 'Phone13-2');
insert into Phone values(14, 'Phone14-1');
insert into Phone values(15, 'Phone15-1');
insert into Phone values(16, 'Phone16-1');
insert into Phone values(17, 'Phone17-1');
insert into Phone values(17, 'Phone17-2');
insert into Phone values(18, 'Phone18-1');
insert into Phone values(19, 'Phone19-1');
insert into Phone values(20, 'Phone20-1');
insert into Phone values(20, 'Phone20-2');
insert into Phone values(21, 'Phone21-1');
insert into Phone values(22, 'Phone22-1');
insert into Phone values(23, 'Phone23-1');
insert into Phone values(23, 'Phone23-2');
insert into Phone values(24, 'Phone24-1');
insert into Phone values(24, 'Phone24-2');
insert into Phone values(24, 'Phone24-3');
insert into Phone values(25, 'Phone25-1');
insert into Phone values(26, 'Phone26-1');
insert into Phone values(27, 'Phone27-1');
insert into Phone values(28, 'Phone28-1');
insert into Phone values(29, 'Phone29-1');
insert into Phone values(30, 'Phone30-1');
insert into Phone values(30, 'Phone30-2');


Create table Accounts(
	accountNumber int,
    balance float,
    accountType varchar(16),
    -- signature
    accountColor varchar(32),
    accountName varchar(32),
    primary key(accountNumber),
    check(accountColor in ('charity', 'current', 'saving'))
);

insert into Accounts(accountNumber, balance, accountType) values(1, 1000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(2, 1000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(3, 1000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(4, 1000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(5, 1000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(6, 1000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(7, 1000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(8, 1000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(9, 1000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(10, 1000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(11, 2000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(12, 2000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(13, 2000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(14, 2000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(15, 2000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(16, 2000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(17, 3000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(18, 3000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(19, 3000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(20, 3000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(21, 3000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(22, 3000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(23, 3000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(24, 2500, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(25, 2500, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(26, 2500, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(27, 2500, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(28, 1200, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(29, 1200, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(30, 1200, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(31, 1300, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(32, 1800, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(33, 5500, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(34, 8000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(35, 500, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(36, 1000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(37, 1000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(38, 2000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(39, 1000, 'saving');
insert into Accounts(accountNumber, balance, accountType) values(40, 3000, 'currnet');
insert into Accounts(accountNumber, balance, accountType) values(41, 4000, 'charity');
insert into Accounts(accountNumber, balance, accountType) values(42, 3000, 'saving');


Create Table Role(
	accountNumber int,
    customerNumber int,
    role varchar(32),
    primary key(accountNumber, customerNumber, role),
    check(role in ('signature', 'pay', 'view', 'owner'))
);


insert into Role values(1, 1, 'owner');
insert into Role values(1, 1, 'view');
insert into Role values(1, 1, 'pay');
insert into Role values(1, 1, 'signature');

insert into Role values(2, 2, 'owner');
insert into Role values(2, 20, 'owner');
insert into Role values(2, 2, 'view');
insert into Role values(2, 20, 'pay');
insert into Role values(2, 1, 'signature');
insert into Role values(2, 2, 'signature');
insert into Role values(2, 3, 'signature');
insert into Role values(2, 4, 'signature');
insert into Role values(2, 5, 'signature');
insert into Role values(2, 6, 'signature');

insert into Role values(3, 3, 'owner');
insert into Role values(3, 3, 'owner');

insert into Role values(4, 4, 'owner');
insert into Role values(4, 40, 'owner');

insert into Role values(5, 5, 'owner');
insert into Role values(5, 21, 'owner');
insert into Role values(5, 22, 'owner');
insert into Role values(5, 23, 'owner');
insert into Role values(5, 25, 'view');
insert into Role values(5, 26, 'view');
insert into Role values(5, 27, 'pay');
insert into Role values(5, 28, 'pay');

insert into Role values(6, 6, 'owner');

insert into Role values(7, 7, 'owner');

insert into Role values(8, 8, 'owner');

insert into Role values(9, 9, 'owner');

insert into Role values(10, 10, 'owner');

insert into Role values(11, 11, 'owner');

insert into Role values(12, 12, 'owner');

insert into Role values(13, 13, 'owner');

insert into Role values(14, 14, 'owner');

insert into Role values(15, 15, 'owner');

insert into Role values(16, 16, 'owner');

insert into Role values(17, 17, 'owner');

insert into Role values(18, 18, 'owner');


insert into Role values(19, 19, 'owner');

insert into Role values(20, 20, 'owner');

insert into Role values(21, 21, 'owner');

insert into Role values(22, 22, 'owner');

insert into Role values(23, 23, 'owner');

insert into Role values(24, 24, 'owner');

insert into Role values(25, 25, 'owner');

insert into Role values(26, 26, 'owner');

insert into Role values(27, 27, 'owner');

insert into Role values(28, 28, 'owner');

insert into Role values(29, 29, 'owner');

insert into Role values(30, 30, 'owner');

insert into Role values(31, 31, 'owner');

insert into Role values(32, 32, 'owner');

insert into Role values(33, 33, 'owner');

insert into Role values(34, 34, 'owner');

insert into Role values(35, 35, 'owner');

insert into Role values(36, 36, 'owner');

insert into Role values(37, 37, 'owner');

insert into Role values(38, 38, 'owner');

insert into Role values(39, 39, 'owner');

insert into Role values(40, 40, 'owner');

insert into Role values(41, 41, 'owner');

insert into Role values(42, 42, 'owner');


Create Table Payment(
	paymentNumber int,
    note text,
    creatorNumber int,
    sourceAccountNumber int,
    total float,
    primary key(paymentNumber),
    foreign key(creatorNumber) references Customer(customerNumber),
    foreign key(sourceAccountNumber) references Accounts(accountNumber)
);


Create Table Transactions(
	paymentNumber int,
	destinationAccountNumber int,
    amount float,
    primary key(paymentNumber, destinationAccountNumber, amount),
    foreign key(paymentNumber) references Payment(paymentNumber)
);


