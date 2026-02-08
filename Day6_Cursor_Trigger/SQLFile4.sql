USE db1;
GO

IF OBJECT_ID('dbo.CustomerUpdateLog','U') IS NOT NULL
    DROP TABLE dbo.CustomerUpdateLog;
GO

CREATE TABLE dbo.CustomerUpdateLog
(
    LogId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT,
    OldPhone VARCHAR(20),
    NewPhone VARCHAR(20),
    OldEmail VARCHAR(100),
    NewEmail VARCHAR(100),
    UpdatedAt DATETIME2 DEFAULT SYSDATETIME()
);
GO

UPDATE dbo.Customers
SET phone = '9999999999'
WHERE customer_id = 101;



SELECT * FROM dbo.CustomerUpdateLog;


SELECT * FROM sys.tables WHERE name='CustomerUpdateLog';
