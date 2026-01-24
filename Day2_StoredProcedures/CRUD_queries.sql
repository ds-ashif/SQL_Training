--CRUD stands for the four basic operations you can do on data:

--Letter	Meaning	SQL command
--C	Create	INSERT
--R	Read	SELECT
--U	Update	UPDATE
--D	Delete	DELETE


USE [dbo]



SELECT  CustomerId, FullName
FROM     Customers 
UPDATE Customers
SET  FullName = 'Ashif'
WHERE  (CustomerId = 4)

go  
dbo 'SELECT'
