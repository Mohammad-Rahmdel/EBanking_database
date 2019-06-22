-- use mysql;

drop table IF EXISTS accessLogs;
drop table IF EXISTS Signatures;
drop table IF EXISTS Transactions;
drop table IF EXISTS Payment;
drop table IF EXISTS Bill;
drop table IF EXISTS Role;
drop table IF EXISTS Accounts;
drop table IF EXISTS Phone;
drop table IF EXISTS Address;
drop table IF EXISTS Customer;

drop table IF EXISTS Signatures_deletion_backup;
drop table IF EXISTS Transactions_deletion_backup;
drop table IF EXISTS Payment_deletion_backup;
drop table IF EXISTS Bill_deletion_backup;
drop table IF EXISTS Role_deletion_backup;
drop table IF EXISTS Accounts_deletion_backup;
drop table IF EXISTS Phone_deletion_backup;
drop table IF EXISTS Address_deletion_backup;
drop table IF EXISTS Customer_deletion_backup;


Create Table Customer(
    customerNumber int,
    id int,
	nam varchar(32),
    familyname varchar(32),
    pass varchar(32),
    primary key(customerNumber)
);


Create Table Customer_deletion_backup(
    customerNumber int,
    id int,
	nam varchar(32),
    familyname varchar(32),
    pass varchar(32)
);



Create table Address(
	customerNumber int,
    Address varchar(128),
    primary key(customerNumber, Address),
    foreign key(customerNumber) references Customer(customerNumber)
);


Create table Address_deletion_backup(
	customerNumber int,
    Address varchar(128)
);


Create table Phone(
	customerNumber int,
    phoneNumber varchar(128),
    primary key(customerNumber, phoneNumber),
    foreign key(customerNumber) references Customer(customerNumber)
);


Create table Phone_deletion_backup(
	customerNumber int,
    phoneNumber varchar(128)
);


Create table Accounts(
	accountNumber int,
    balance float,
    accountType varchar(16),
    NoSignatures int default 1,
    accountColor varchar(32),
    accountName varchar(32),
    primary key(accountNumber),
    check(accountColor in ('charity', 'current', 'saving'))
);


Create table Accounts_deletion_backup(
	accountNumber int,
    balance float,
    accountType varchar(16),
    NoSignatures int,
    accountColor varchar(32),
    accountName varchar(32)
);


Create Table Role(
	accountNumber int,
    customerNumber int,
    role varchar(32),
    primary key(accountNumber, customerNumber, role),
    foreign key(customerNumber) references Customer(customerNumber),
    foreign key(accountNumber) references Accounts(accountNumber),
    check(role in ('sign', 'pay', 'view', 'owner'))
);


Create Table Role_deletion_backup(
	accountNumber int,
    customerNumber int,
    role varchar(32)
);


Create Table Bill(
	id int auto_increment,
	eventTime timestamp,
    fund float,
    description text,
    billType varchar(16),
    primary key(id),
    check(billType in ('send', 'receive'))
);


Create Table Bill_deletion_backup(
	eventTime timestamp,
    fund float,
    description text,
    billType varchar(16)
);


Create Table Payment(
	paymentNumber int,
    note text,
    creatorNumber int,
    sourceAccountNumber int,
    total float default 0,
    state BIT default 0,
    primary key(paymentNumber),
    foreign key(creatorNumber) references Customer(customerNumber),
    foreign key(sourceAccountNumber) references Accounts(accountNumber)
);


Create Table Payment_deletion_backup(
	paymentNumber int,
    note text,
    creatorNumber int,
    sourceAccountNumber int,
    total float,
    state BIT
);


Create Table Transactions(
	paymentNumber int,
	destinationAccountNumber int,
    amount float,
    primary key(paymentNumber, destinationAccountNumber),
    foreign key(paymentNumber) references Payment(paymentNumber)
);



Create Table Transactions_deletion_backup(
	paymentNumber int,
	destinationAccountNumber int,
    amount float
);


Create Table Signatures(
	customerNumber int,
    paymentNumber int,
    primary key(paymentNumber, customerNumber),
    foreign key(customerNumber) references Customer(customerNumber),
    foreign key(paymentNumber) references Payment(paymentNumber)
);


Create Table Signatures_deletion_backup(
	customerNumber int,
    paymentNumber int
);


Create Table accessLogs(
	customerNumber int,
    access varchar(8),
    logTime timestamp,
	typee varchar(16),
    foreign key(customerNumber) references Customer(customerNumber),
	check(typee in ('grant', 'revoke'))
);





