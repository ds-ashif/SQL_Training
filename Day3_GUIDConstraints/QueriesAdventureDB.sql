USE AdventureWorks2025;
GO

-- ERROR:
-- A table name alone is NOT a SQL statement.
-- SQL Server expects a command like SELECT, INSERT, UPDATE, DELETE.
-- These lines will cause: "Incorrect syntax near '.'"

[Person].[Address]
[Person].[Person]


-- CORRECT:
-- This is a valid SELECT statement.
-- TOP 15 limits the output to 15 rows.

SELECT TOP 15 * FROM [Person].[Person];


-- ERROR (EXPECTED in AdventureWorks):
-- BusinessEntityID is a FOREIGN KEY.
-- It must already exist in Person.BusinessEntity.
-- AdventureWorks also prevents direct inserts for learning purposes.
-- That is why this INSERT fails.
INSERT INTO [Person].[Person]( BusinessEntityID,PersonType,NameStyle,Title,FirstName,LastName )
VALUES ( 20778,'EM',0,'Mr.','ASIF','AHAMAD');


-- ERROR:
-- ORDER BY is NOT allowed inside a UNION / UNION ALL block
-- ORDER BY can appear ONLY at the very end.

SELECT TOP 15 BusinessEntityID, LastName
FROM [Person].[Person]

UNION ALL

SELECT TOP 15 BusinessEntityID, LastName
FROM [Person].[Person]
ORDER BY BusinessEntityID DESC;


--  ERROR (same reason as above):
-- UNION removes duplicates, but ORDER BY is still illegal here.
SELECT TOP 15 BusinessEntityID, LastName
FROM [Person].[Person]

UNION

SELECT TOP 15 BusinessEntityID, LastName
FROM [Person].[Person]
ORDER BY BusinessEntityID DESC;
