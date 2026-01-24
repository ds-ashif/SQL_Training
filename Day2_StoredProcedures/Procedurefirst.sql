USE [Customer-Order]
GO
/****** Object:  StoredProcedurePractice [dbo].[Procedurefirst]    Script Date: 22-1-26 11:37:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Action	Command
--Create procedure	CREATE PROCEDURE
--View procedure code	sp_helptext 'ProcName'
--Run procedure	EXEC ProcName values
--Separate batches	GO
--Create Procedure MyPractice (used for creating a procedure)

--First Procedure
-- CREATE PROCEDURE [dbo].[Procedurefirst]
  
ALTER PROCEDURE [dbo].[Procedurefirst]
@segmentName varchar(50),
@city varchar(50)


as
Begin

select * from Customers where City=@city or Segment=@segmentName;
SELECT 'Hello SQL Procedures' AS Message;
end--till  here is the syntax of a basic procedure in sql acts like a container
