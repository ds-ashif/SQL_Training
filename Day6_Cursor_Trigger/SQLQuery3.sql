-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Ashif>
-- Create date: <05/02/2026>
-- =============================================
IF OBJECT_ID('dbo.Tri_Customers','TR') IS NOT NULL
    DROP TRIGGER dbo.Tri_Customers;
GO


CREATE TRIGGER Tri_Customers
ON dbo.Customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.CustomerUpdateLog
        (CustomerId, OldPhone, NewPhone, OldEmail, NewEmail)
    SELECT
        d.customer_id,
        d.phone,
        i.phone,
        d.email,
        i.email
    FROM deleted d
    JOIN inserted i
        ON d.customer_id = i.customer_id;
END
GO
