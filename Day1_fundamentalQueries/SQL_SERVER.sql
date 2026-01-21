/* ================================
   A) SELECT * (All Columns)
   ================================ */
SELECT *
FROM dbo.Customers;


/* ================================
   B) SELECT Specific Columns
   ================================ */
SELECT CustomerId, FullName, City
FROM dbo.Customers;


/* ================================
   C) SELECT DISTINCT
   ================================ */
SELECT DISTINCT City
FROM dbo.Customers;


/* ================================
   D) Column Alias (AS)
   ================================ */
SELECT FullName AS CustomerName,
       City AS CustomerCity
FROM dbo.Customers;


/* ================================
   E) WHERE Clause
   ================================ */
SELECT *
FROM dbo.Customers
WHERE City = 'Chennai';


/* ================================
   F) WHERE with AND / OR
   ================================ */
SELECT *
FROM dbo.Orders
WHERE Status = 'Delivered'
  AND PaymentMode = 'UPI';


/* ================================
   G) IN Operator
   ================================ */
SELECT *
FROM dbo.Customers
WHERE City IN ('Chennai', 'Coimbatore');


/* ================================
   H) BETWEEN Operator
   ================================ */
SELECT *
FROM dbo.Orders
WHERE Amount BETWEEN 800 AND 3000;


/* ================================
   I) LIKE Operator
   ================================ */
SELECT *
FROM dbo.Customers
WHERE FullName LIKE 'S%';