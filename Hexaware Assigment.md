# Task 1: Database Design

## 1.1. Create the database named "HMBank"
```sql
CREATE DATABASE HMBank;
```

## 1.2 Define the schema for the Customers, Accounts, and Transactions tables based on the provided schema.

```sql
CREATE TABLE [Customers] (
  [customer_id] VARCHAR(255),
  [first_name] VARCHAR(255),
  [last_name] VARCHAR(255),
  [DOB] DATE,
  [email] VARCHAR(255),
  [phone_number] VARCHAR(10),
  [Address] VARCHAR(255),
  PRIMARY KEY ([customer_id])
);

CREATE TABLE [Accounts] (
  [Account_id] VARCHAR(20),
  [Customer_id] VARCHAR(255),
  [Account_Type] VARCHAR(255),
  [Balance] INT,
  PRIMARY KEY ([Account_id]),
  CONSTRAINT [FK_Accounts.Customer_id]
    FOREIGN KEY ([Customer_id])
      REFERENCES [Customers]([customer_id])
);

CREATE TABLE [Transaction] (
  [Transaction_id] VARCHAR(20),
  [Account_Id] VARCHAR(20),
  [Transaction_Type] VARCHAR(255),
  [Amount] INT,
  [Transaction_Date] DATE,
  PRIMARY KEY ([Transaction_id]),
  CONSTRAINT [FK_Transaction.Account_Id]
    FOREIGN KEY ([Account_Id])
      REFERENCES [Accounts]([Account_id])
);

```

## 1.4. Create an ERD (Entity Relationship Diagram) for the database.
<!-- ERD Diagram -->
![image](https://github.com/anusha-tikarya/Hexaware-ASSIGMENT-/assets/84814767/bca4c19c-9702-4441-a014-7d4b272ab33f)

## 1.5. Create appropriate Primary Key and Foreign Key constraints for referential integrity.

```sql
ALTER TABLE [Transaction]
ADD CONSTRAINT [FK_Transaction.Account_Id]
    FOREIGN KEY ([Account_Id])
      REFERENCES [Accounts]([Account_id]);
```

## 1.6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships.

```sql
CREATE TABLE [Customers] (
  [customer_id] VARCHAR(255),
  [first_name] VARCHAR(255),
  [last_name] VARCHAR(255),
  [DOB] DATE,
  [email] VARCHAR(255),
  [phone_number] VARCHAR(10),
  [Address] VARCHAR(255),
  PRIMARY KEY ([customer_id])
);

CREATE TABLE [Accounts] (
  [Account_id] VARCHAR(20),
  [Customer_id] VARCHAR(255),
  [Account_Type] VARCHAR(255),
  [Balance] INT,
  PRIMARY KEY ([Account_id]),
  CONSTRAINT [FK_Accounts.Customer_id]
    FOREIGN KEY ([Customer_id])
      REFERENCES [Customers]([customer_id])
);

CREATE TABLE [Transaction] (
  [Transaction_id] VARCHAR(20),
  [Account_Id] VARCHAR(20),
  [Transaction_Type] VARCHAR(255),
  [Amount] INT,
  [Transaction_Date] DATE,
  PRIMARY KEY ([Transaction_id]),
  CONSTRAINT [FK_Transaction.Account_Id]
    FOREIGN KEY ([Account_Id])
      REFERENCES [Accounts]([Account_id])
);
```

# Task 2: Select, Where, Between, AND, LIKE:

## 2.1. Write a SQL query to retrieve the name, account type and email of all customers.

```sql
SELECT C.first_name, C.email, A.Account_Type
FROM Customers C
INNER JOIN Accounts A ON C.customer_id = A.Customer_id;
```

## 2.2. Write a SQL query to list all transactions corresponding to customers.

```sql
SELECT *
FROM [Transaction] T
INNER JOIN Accounts A ON T.Account_id = A.Account_id
INNER JOIN Customers C ON A.Customer_id = C.customer_id;
```

## 2.3. Write a SQL query to increase the balance of a specific account by a certain amount.

```sql
UPDATE Accounts
SET Balance = Balance + 20000
WHERE Account_id = 'A1'; 
```

## 2.4. Write a SQL query to Combine first and last names of customers as a full_name.

```sql
SELECT (first_name || ' ' || last_name) AS Full_name FROM Customers;
```

## 2.5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.

```sql
DELETE FROM Accounts
WHERE Balance = 0
AND Account_Type = 'Savings';
```

## 2.6. Write a SQL query to Find customers living in a specific city.

```sql
SELECT * FROM Customers
WHERE Address LIKE 'Indore';
```

## 2.7. Write a SQL query to Get the account balance for a specific account.

```sql
SELECT Balance, Account_id FROM Accounts
WHERE Balance = 10000;
```

## 2.8. Write a SQL query to List all current accounts with a balance greater than $1,000.

```sql
SELECT * FROM Accounts 
WHERE Balance > 1000
AND Account_Type = 'Current';
```

## 2.9. Write a SQL query to Retrieve all transactions for a specific account.

```sql
SELECT * FROM [Transaction]
WHERE Account_id = 'A1';
```

## 2.10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.

```sql
SELECT Account_id, Account_Type, (Balance * 0.03) AS Interest_Accrued
FROM Accounts
WHERE Account_Type = 'Savings';
```

## 2.11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.

```sql
SELECT * FROM Accounts
WHERE Balance < 3000;
```

## 2.12. Write a SQL query to Find customers not living in a specific city.

```sql
SELECT * FROM Customers
WHERE Address NOT LIKE 'Indore';
```

# Task 3: Aggregate functions, Having, Order By, Group By and Joins:

## 3.1. Write a SQL query to Find the average account balance for all customers.

```sql
SELECT AVG(Balance) AS Avg_Balance FROM Accounts;
```

## 3.2. Write a SQL query to Retrieve the top 10 highest account balances.

```sql
SELECT * FROM Accounts
ORDER BY Balance DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
```

## 3.3. Write a SQL query to Calculate Total Deposits for All Customers on a specific date.

```sql
SELECT SUM(Amount) AS Total_Deposit
FROM [Transaction]
WHERE Transaction_Type = 'Deposit'
AND Transaction_Date = '2024-04-30';
```

## 3.4. Write a SQL query to Find the Oldest and Newest Customers.

```sql
SELECT TOP 1 customer_id, [ first. name] last_name, DOB
FROM Customers
ORDER BY DOB ASC; 
-- Newest Customer
SELECT TOP 1 customer_id, [ first. name] , last_name, DOB
FROM Customers
ORDER BY DOB DESC;
```

## 3.5. Write a SQL query to Retrieve transaction details along with the account type.

```sql
SELECT T.Transaction_id, T.Transaction_Type, A.Account_id, T.Amount, T.Transaction_Date, A.Account_Type
FROM [Transaction] T
INNER JOIN Accounts A ON T.Account_id = A.Account_id;
```

## 3.6. Write a SQL query to Get a list of customers along with their account details.

```sql
SELECT * FROM Customers
INNER JOIN Accounts ON Customers.customer_id = Accounts.Customer_id;
```

## 3.7. Write a SQL query to Retrieve transaction details along with customer information for a

 specific account.

```sql
SELECT T.Transaction_id, T.Transaction_Type, T.Amount, T.Transaction_Date,
       C.customer_id, C.first_name, C.last_name, C.DOB, C.email, C.phone_number, C.Address
FROM [Transaction] T
INNER JOIN Accounts A ON T.Account_id = A.Account_id
INNER JOIN Customers C ON A.Customer_id = C.customer_id
WHERE A.Account_id = 'A1';
```

## 3.8. Write a SQL query to Identify customers who have more than one account.

```sql
SELECT C.customer_id, C.first_name, C.last_name, COUNT(A.Account_id) AS num_accounts
FROM Customers C
INNER JOIN Accounts A ON C.customer_id = A.Customer_id
GROUP BY C.customer_id, C.first_name, C.last_name
HAVING COUNT(A.Account_id) > 1;
```

## 3.9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.

```sql
SELECT (SUM(T1.Amount) - SUM(T2.Amount)) AS difference_amount 
FROM [Transaction] T1
JOIN [Transaction] T2 ON T1.Account_Id = T2.Account_Id
WHERE T1.Transaction_Type = 'withdrawal' AND T2.Transaction_Type = 'deposit';
```

## 3.10. Write a SQL query to Calculate the average daily balance for each account over a specified period.

```sql
-- Not Provided
```

## 3.11. Write a SQL query to Calculate the total balance for each account type.

```sql
SELECT Account_Type, SUM(Balance) AS Total_Balance
FROM Accounts
GROUP BY Account_Type;
```

## 3.12. Identify accounts with the highest number of transactions order by descending order.

```sql
SELECT A.Account_id, A.Customer_id, A.Account_Type, A.balance, COUNT(T.Account_Id) AS NO_Transaction
FROM Accounts AS A
INNER JOIN [Transaction] AS T ON A.Account_id = T.Account_Id
GROUP BY A.Account_id, A.Customer_id, A.Account_Type, A.balance
ORDER BY NO_Transaction DESC;
```

## 3.13. List customers with high aggregate account balances, along with their account types.

```sql
SELECT C.customer_id, C.first_name, C.last_name, A.Account_Type, SUM(A.balance) AS total_balance
FROM Customers AS C
INNER JOIN Accounts AS A ON C.customer_id = A.Customer_id
GROUP BY C.customer_id, C.first_name, C.last_name, A.Account_Type
HAVING SUM(A.balance) > 10000 
ORDER BY total_balance DESC;
```

## 3.14. Identify and list duplicate transactions based on transaction amount, date, and account.

```sql
SELECT Account_id, Transaction_id, Amount, Transaction_Date, COUNT(*) AS duplicate 
FROM [Transaction]
GROUP BY Account_id, Transaction_Date, Amount
HAVING COUNT(*) > 1;
```

# Task 4: Subquery and its type:

## 4.1. Retrieve the customer(s) with the highest account balance.

```sql
SELECT C.customer_id, C.first_name, C.last_name, C.email, C.phone_number, A.balance
FROM Customers C
INNER JOIN Accounts A ON C.customer_id = A.Customer_id
ORDER BY Balance DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;
```

## 4.2. Calculate the average account balance for customers who have more than one account.

```sql
SELECT C.customer_id, AVG(A.balance) AS Avg_balance
FROM Customers C
INNER JOIN Accounts A ON C.customer_id = A.Customer_id
GROUP BY C.customer_id
HAVING COUNT(A.Customer_id) > 1;
```

## 4.3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.

```sql
SELECT *
FROM Accounts A
LEFT JOIN [Transaction] T ON A.Account_id = T.Account_id
WHERE Amount > (SELECT AVG(Amount) FROM [Transaction]);
```

## 4.4. Identify customers who have no recorded transactions.

```sql
SELECT C.customer_id
FROM Customers C
LEFT JOIN Accounts A ON C.customer_id = A.Customer_id
LEFT JOIN [Transaction] T ON A.Account_id = T.Account_id
GROUP BY C.customer_id
HAVING COUNT(T.Account_id) = 0;
```

## 4.5. Calculate the total balance of accounts with no recorded transactions.

```sql
SELECT SUM(A.Balance) AS total_balance
FROM Accounts A
LEFT JOIN [Transaction] T ON A.Account_id = T.Account_id
GROUP BY A.Balance
HAVING COUNT(T.Account_id) = 0;
```

## 4.6. Retrieve transactions for accounts with the lowest balance.

```sql
SELECT T.Transaction_id, T.Transaction_Date, T.Amount, T.Account_Id, T.Transaction_Type
FROM Accounts A
INNER JOIN [Transaction] T ON A.Account_id = T.Account_id
WHERE A.Balance = (SELECT MIN(Balance)

 FROM Accounts);
```

## 4.7. Identify customers who have accounts of multiple types.

```sql
SELECT Customer_id
FROM Accounts
GROUP BY Customer_id
HAVING COUNT(DISTINCT Account_Type) > 1;
```

## 4.8. Calculate the percentage of each account type out of the total number of accounts.

```sql
SELECT 
    (COUNT(CASE WHEN A.Account_Type = 'Savings' THEN 1 END) * 100 / COUNT(*)) AS Savings_Percentage,
    (COUNT(CASE WHEN A.Account_Type = 'Current' THEN 1 END) * 100 / COUNT(*)) AS Current_Percentage
FROM Accounts A;
```

## 4.9. Retrieve all transactions for a customer with a given customer_id.

```sql
SELECT *
FROM [Transaction]
WHERE Transaction_id IN (
    SELECT Transaction_id
    FROM [Transaction] T
    JOIN Accounts A ON T.Account_Id = A.Account_id
    JOIN Customers C ON A.Customer_id = C.customer_id
    WHERE C.customer_id = 'C1'
);
```

## 4.10. Calculate the total balance for each account type, including a subquery within the SELECT clause.

```sql
SELECT 
    [Account Type],
    (SELECT SUM(Balance) FROM Accounts WHERE [Account Type] = A.[Account Type]) AS Total_Balance
FROM (
    SELECT DISTINCT [Account Type] FROM Accounts
) AS A;
```
```

This Markdown file contains SQL queries corresponding to the tasks you mentioned, organized under each task heading.
