USE Employees;
GO
/*
INSERT INTO dbo.emp (Full_Name, Address_City, Salary)
VALUES
('John Smith', 'New York', 55000),
('Priya Sharma', 'Delhi', 62000),
('Ali Khan', 'Dubai', 58000),
('Maria Garcia', 'Madrid', 60000);
*/


---  select * from dbo.emp;


--- Second highest query using Offset
/*
SELECT *
FROM dbo.emp
ORDER BY Salary DESC
OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY;
*/

--- second highest salary using subquery

SELECT MAX(Salary) AS SecondHighestSalary
FROM dbo.emp
WHERE Salary < (SELECT MAX(Salary) FROM dbo.emp);


