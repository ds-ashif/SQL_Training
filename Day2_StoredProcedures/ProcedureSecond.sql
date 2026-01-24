USE [Customer_Order]
GO
/****** Object:  StoredProcedurePractice [dbo].[ProcedureSecond]    Script Date: 22-1-26 11:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Second Procedure
--create
ALTER procedure [dbo].[ProcedureSecond]
as
Begin
	Declare @total int;
	Select @total=COUNT(*) from Customers;
	if @total>2
		Print('More than 2');
	else
		Print('Less than 2');
end
