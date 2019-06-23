select * from Signatures
select * from Accounts
select * from Payment 
select * from Transactions
select * from Bill
select * from Role

-- Q1
select * from customers_with_sign_authority;
    
    
-- Q2
select accountNumber
from Accounts natural join(
select count(*) as signs, accountNumber
from Role
where role='sign'
group by accountNumber ) as sub
where signs > NoSignatures;


-- Q3
select * from ready_payments;


-- Q4
call transactions_list(3);


-- Q5
call deleted_signs_list(2);


-- Q6
call sharing_accounts(1, 2);


-- Q7
call payments_list(2);


-- Q8 
call specific_payments_list(1);


-- Q9
call specific_transactions_list(3, 150);