USE AdventureWorks2025;
GO

DROP TABLE IF EXISTS dbo.SOH_Practice;
SELECT TOP (300000)
  SalesOrderID, CustomerID, OrderDate, SubTotal, TaxAmt, Freight, TotalDue
INTO dbo.SOH_Practice
FROM Sales.SalesOrderHeader
ORDER BY SalesOrderID;

-- Create a clustered index on SalesOrderID (common pattern)
-- This leaves our search columns (CustomerID, OrderDate) without a supporting index.
CREATE CLUSTERED INDEX CX_SOH_Practice_SalesOrderID
ON dbo.SOH_Practice(SalesOrderID);


--- CREATE INDEX IX_SOH_Practice_CustomerID
--- ON dbo.SOH_Practice(CustomerID)

--- SELECT *
--- FROM dbo.SOH_Practice
--- WHERE CustomerID = 11000;


