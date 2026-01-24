USE [Customer_Order]
GO
/****** Object:  StoredProcedurePractice [dbo].[ProcedureThird]    Script Date: 22-1-26 11:40:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[ProcedureThird]
	-- Add the parameters for the stored procedure here
	@orderid int,
	@orderDate date
AS
BEGIN
	select *  from Orders where OrderId=@orderid or OrderDate=@orderDate;
END
