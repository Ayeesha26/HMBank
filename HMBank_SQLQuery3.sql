-- TASK:1 Create the database named "HMBank"
CREATE DATABASE HMBank;
-- Use the HMBank database
USE HMBank;
-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
	address VARCHAR(50)
);
-- Create the Accounts table
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    account_type VARCHAR(50),
    balance DECIMAL(18, 2)
);
-- Create the Transactions table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT FOREIGN KEY REFERENCES Accounts(account_id),
    transaction_type VARCHAR(50),
    amount DECIMAL(18, 2),
    transaction_date DATE
);
--TASK:2 Insert sample records into the Customers table
INSERT INTO Customers (customer_id, first_name, last_name, DOB, email, phone_number, address)
VALUES 
(1, 'Ayesha', 'Shahul', '2002-05-26', 'ayesha.shahul@example.com', '123-456-7890', 'Chennai'),
(2, 'Fatima', 'Hameed', '2000-10-05', 'fatima.hameed@example.com', '456-789-0123', 'Mumbai'),
(3, 'Ishita', 'Menon', '1978-12-10', 'ishita.menon@example.com', '789-012-3456','Delhi'),
(4, 'Meera', 'Patel', '1982-03-25', 'meera.patel@example.com', '012-345-6789', 'Bangalore'),
(5, 'Priya', 'Sharma', '1995-07-03', 'priya.sharma@example.com', '234-567-8901', ' Hyderabad'),
(6, 'Sneha', 'Singh', '1970-11-30', 'sneha.singh@example.com', '567-890-1234', 'Kolkata'),
(7, 'Trisha', 'Gupta', '1988-09-18', 'trisha.gupta@example.com', '890-123-4567', 'Pune'),
(8, 'Neha', 'Malhotra', '1992-02-14', 'neha.malhotra@example.com', '678-901-2345', 'Ahmedabad'),
(9, 'Aradhana', 'Raj', '1983-06-28', 'aradhana.raj@example.com', '901-234-5678', 'Lucknow'),
(10, 'Shreya', 'Kumar', '1975-04-12', 'shreya.kumar@example.com', '345-678-9012', 'Jaipur');
-- Insert sample records into the Accounts table
INSERT INTO Accounts (account_id, customer_id, account_type, balance)
VALUES 
(101, 1, 'savings', 5000.00),
(102, 2, 'current', 2500.00),
(103, 3, 'savings', 10000.00),
(104, 4, 'current', 7500.00),
(105, 5, 'zero_balance', 0.00),
(106, 6, 'savings', 3000.00),
(107, 7, 'current', 6000.00),
(108, 8, 'savings', 8000.00),
(109, 9, 'current', 4000.00),
(110, 10, 'savings', 7000.00);
-- Insert sample records into the Transactions table
INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES 
(201, 101, 'deposit', 1000.00, '2024-01-05'),
(202, 102, 'withdrawal', 500.00, '2024-01-10'),
(203, 103, 'deposit', 2000.00, '2024-01-15'),
(204, 104, 'withdrawal', 1000.00, '2024-01-20'),
(205, 105, 'deposit', 500.00, '2024-01-25'),
(206, 106, 'withdrawal', 200.00, '2024-02-01'),
(207, 107, 'deposit', 1500.00, '2024-02-05'),
(208, 108, 'withdrawal', 800.00, '2024-02-10'),
(209, 109, 'deposit', 1000.00, '2024-02-15'),
(210, 110, 'withdrawal', 500.00, '2024-02-20');
--1.Write a SQL query to retrieve the name, account type and email of all customers. 
SELECT Customers.first_name, Customers.last_name, Accounts.account_type, Customers.email
FROM Customers, Accounts
WHERE Customers.customer_id = Accounts.customer_id;
--2.Write a SQL query to list all transaction corresponding customer 
SELECT transaction_id, account_id, transaction_type, amount, transaction_date
FROM Transactions
WHERE account_id IN (SELECT account_id FROM Accounts);
--3.Write a SQL query to increase the balance of a specific account by a certain amount.
UPDATE Accounts
SET balance = balance + 1000
WHERE account_id = 101;
--4.Write a SQL query to Combine first and last names of customers as a full_name
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Customers;
--5.Write a SQL query to remove accounts with a balance of zero where the account type is savings.
DELETE FROM Accounts
WHERE balance = 0
AND account_type = 'savings';
--6.Write a SQL query to Find customers living in a specific city
SELECT *
FROM Customers
WHERE address LIKE '%Mumbai%';
--7.Write a SQL query to Get the account balance for a specific account
SELECT balance
FROM Accounts
WHERE account_id = 101;
--8.Write a SQL query to List all current accounts with a balance greater than $1,000.
SELECT *
FROM Accounts
WHERE account_type = 'current' AND balance > 1000.00;
--9.Write a SQL query to Retrieve all transactions for a specific account.
SELECT *
FROM Transactions
WHERE account_id = 101;
--10.Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate
DECLARE @interest_rate DECIMAL(5, 2) =  4.5%; -- Example interest rate (2.5%)

SELECT account_id, balance * @interest_rate / 100 AS interest_accrued
FROM Accounts
WHERE account_type = 'savings';
--11.Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
DECLARE @overdraft_limit DECIMAL(18, 2) = 1000.00; -- Example overdraft limit
SELECT *
FROM Accounts
WHERE balance < @overdraft_limit;
--12.Write a SQL query to Find customers not living in a specific city.
SELECT *
FROM Customers
WHERE address NOT LIKE '%Mumbai%';
--1.Find the average account balance for all customers
SELECT AVG(balance) AS average_balance
FROM Accounts;
--2.To Retrieve the top 10 highest account balances
SELECT TOP 10 account_id, balance
FROM Accounts
ORDER BY balance DESC;
--3.Calculate Total Deposits for All Customers in a specific date
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
AND transaction_date = '2024-01-05';
--4.Find the Oldest and Newest Customers
SELECT MIN(DOB) AS oldest_customer_DOB, MAX(DOB) AS newest_customer_DOB
FROM Customers;
--5.Retrieve transaction details along with the account type
SELECT Transactions.transaction_id, Transactions.account_id, Transactions.transaction_type, Transactions.amount, Transactions.transaction_date, Accounts.account_type
FROM Transactions, Accounts
WHERE Transactions.account_id = Accounts.account_id;
--6.Get a list of customers along with their account details
SELECT Customers.*, Accounts.*
FROM Customers, Accounts
WHERE Customers.customer_id = Accounts.customer_id;
--7.Retrieve transaction details along with customer information for a specific account
SELECT Transactions.*, Customers.*
FROM Transactions, Accounts, Customers
WHERE Transactions.account_id = Accounts.account_id
AND Accounts.customer_id = Customers.customer_id
AND Transactions.account_id = 101; 
--8.Identify customers who have more than one account
SELECT customer_id
FROM Accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1;
--9.Calculate the difference in transaction amounts between deposits and withdrawals
SELECT SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE -amount END) AS difference
FROM Transactions;
--10.Calculate the average daily balance for each account over a specified period
SELECT account_id, AVG(balance) AS average_daily_balance
FROM Accounts
GROUP BY account_id;
--11.Calculate the total balance for each account type
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;
--12.Identify accounts with the highest number of transactions ordered by descending order
SELECT account_id, COUNT(*) AS transaction_count
FROM Transactions
GROUP BY account_id
ORDER BY transaction_count DESC;
--13.List customers with high aggregate account balances, along with their account types
SELECT Customers.customer_id, Customers.first_name, Customers.last_name, Customers.DOB, Customers.email, Customers.phone_number, Customers.address,
       Accounts.account_type, SUM(Accounts.balance) AS aggregate_balance
FROM Customers, Accounts
WHERE Customers.customer_id = Accounts.customer_id
GROUP BY Customers.customer_id, Customers.first_name, Customers.last_name, Customers.DOB, Customers.email, Customers.phone_number, Customers.address, Accounts.account_type
ORDER BY aggregate_balance DESC;
--14.Identify and list duplicate transactions based on transaction amount, date, and account
SELECT MIN(transaction_id) AS transaction_id, account_id, transaction_type, amount, transaction_date
FROM Transactions
GROUP BY account_id, transaction_type, amount, transaction_date
HAVING COUNT(*) > 1;
--1.Retrieve the customer(s) with the highest account balance
SELECT TOP 1 C.customer_id, C.first_name, C.last_name
FROM Customers C
JOIN Accounts A ON C.customer_id = A.customer_id
ORDER BY A.balance DESC;
--2.Calculate the average account balance for customers who have more than one account
SELECT AVG(A.balance) AS average_balance
FROM Accounts A
JOIN (
    SELECT customer_id
    FROM Accounts
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) MultipleAccounts ON A.customer_id = MultipleAccounts.customer_id;
--3.Retrieve accounts with transactions whose amounts exceed the average transaction amount
SELECT account_id, transaction_id, amount
FROM Transactions
WHERE amount > (SELECT AVG(amount) FROM Transactions);
--4.Identify customers who have no recorded transactions
SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Transactions);
--5.Calculate the total balance of accounts with no recorded transactions
SELECT SUM(balance) AS total_balance
FROM Accounts
WHERE account_id NOT IN (SELECT DISTINCT account_id FROM Transactions);
--6.Retrieve transactions for accounts with the lowest balance
SELECT account_id, transaction_id, amount
FROM Transactions
WHERE account_id IN (SELECT TOP 1 account_id FROM Accounts ORDER BY balance ASC);
--7.Identify customers who have accounts of multiple types
SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Accounts GROUP BY customer_id HAVING COUNT(DISTINCT account_type) > 1);
--8.Calculate the percentage of each account type out of the total number of accounts
SELECT account_type, 
       COUNT(*) AS count_accounts,
       (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM Accounts
GROUP BY account_type;
--9.Retrieve all transactions for a customer with a given customer_id
SELECT *
FROM Transactions
WHERE account_id IN (SELECT account_id FROM Accounts WHERE customer_id = 1);
--10.Calculate the total balance for each account type, including a subquery within the SELECT clause
SELECT 
    account_type,
    (SELECT SUM(balance) FROM Accounts WHERE account_type = A.account_type) AS total_balance
FROM 
    (SELECT DISTINCT account_type FROM Accounts) AS A;
























