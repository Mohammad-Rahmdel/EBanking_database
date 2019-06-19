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




Create table Address(
	customerNumber int,
    Address varchar(128),
    primary key(customerNumber, Address),
    foreign key(customerNumber) references Customer(customerNumber)
);



Create table Phone(
	customerNumber int,
    phoneNumber varchar(128),
    primary key(customerNumber, phoneNumber),
    foreign key(customerNumber) references Customer(customerNumber)
);


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


Create Table Role(
	accountNumber int,
    customerNumber int,
    role varchar(32),
    primary key(accountNumber, customerNumber, role),
    check(role in ('signature', 'pay', 'view', 'owner'))
);



Create Table Bill(
	eventTime timestamp,
    fund float,
    description text,
    billType varchar(16),
    primary key(eventTime),
    check(billType in ('deposit', 'withdraw'))
);




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


