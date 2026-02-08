use ProductInfo
Go

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL
    DROP TABLE dbo.Products;
GO

CREATE TABLE dbo.Products
(
    ProductId     INT IDENTITY(1,1) PRIMARY KEY,
    ProductName   VARCHAR(100) NOT NULL,
    Category      VARCHAR(50)  NOT NULL,
    Price         DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    StockQty      INT NOT NULL CHECK (StockQty >= 0),
    IsActive      BIT NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

INSERT INTO dbo.Products (ProductName, Category, Price, StockQty)
VALUES
('Wireless Mouse', 'Electronics', 799.00, 50),
('Mechanical Keyboard', 'Electronics', 2499.00, 25),
('Running Shoes', 'Fashion', 1899.00, 40),
('Water Bottle', 'Fitness', 399.00, 120),
('Laptop Backpack', 'Accessories', 1499.00, 35),
('USB-C Cable', 'Electronics', 299.00, 15),
('Gym Gloves', 'Fitness', 499.00, 28);
GO

SELECT * FROM dbo.Products ORDER BY ProductId;
GO


IF OBJECT_ID('dbo.ReorderLog', 'U') IS NOT NULL
    DROP TABLE dbo.ReorderLog;
GO

CREATE TABLE dbo.ReorderLog
(
    LogId      INT IDENTITY(1,1) PRIMARY KEY,
    ProductId  INT NOT NULL,
    Message    VARCHAR(200) NOT NULL,
    CreatedAt  DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

DECLARE @ProductId INT;
DECLARE @ProductName VARCHAR(100);
DECLARE @Price DECIMAL(10,2);

-- 1) Declare cursor
DECLARE curProducts CURSOR FAST_FORWARD
FOR
    SELECT ProductId, ProductName, Price
    FROM dbo.Products
    ORDER BY ProductId;

-- 2) Open cursor
OPEN curProducts;

-- 3) Fetch first row
FETCH NEXT FROM curProducts INTO @ProductId, @ProductName, @Price;

-- 4) Loop until no more rows
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'ProductId=' + CAST(@ProductId AS VARCHAR(10))
        + ' | Name=' + @ProductName
        + ' | Price=' + CAST(@Price AS VARCHAR(20));

    -- fetch next row
    FETCH NEXT FROM curProducts INTO @ProductId, @ProductName, @Price;
END

-- 5) Close + Deallocate
CLOSE curProducts;
DEALLOCATE curProducts;



IF OBJECT_ID('dbo.usp_ReorderLog_Cursor', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_ReorderLog_Cursor;
GO

CREATE PROCEDURE dbo.usp_ReorderLog_Cursor
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Clear old log
    TRUNCATE TABLE dbo.ReorderLog;

    -- 2️⃣ Variable declarations
    DECLARE @ProductId INT;
    DECLARE @ProductName VARCHAR(100);
    DECLARE @StockQty INT;

    -- 3️⃣ Cursor declaration
    DECLARE curLowStock CURSOR FAST_FORWARD
    FOR
        SELECT ProductId, ProductName, StockQty
        FROM dbo.Products
        WHERE StockQty < 30
        ORDER BY StockQty ASC;

    -- 4️⃣ Open cursor
    OPEN curLowStock;

    FETCH NEXT FROM curLowStock 
    INTO @ProductId, @ProductName, @StockQty;

    -- 5️⃣ Loop
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO dbo.ReorderLog (ProductId, Message)
        VALUES
        (
            @ProductId,
            'Reorder needed for ' + @ProductName +
            ' (Stock=' + CAST(@StockQty AS VARCHAR(10)) + ')'
        );

        FETCH NEXT FROM curLowStock 
        INTO @ProductId, @ProductName, @StockQty;
    END

    -- 6️⃣ Close & Deallocate
    CLOSE curLowStock;
    DEALLOCATE curLowStock;

    -- 7️⃣ Show result
    SELECT *
    FROM dbo.ReorderLog
    ORDER BY LogId;
END;
GO



IF OBJECT_ID('dbo.PriceChangeLog', 'U') IS NOT NULL
    DROP TABLE dbo.PriceChangeLog;
GO

CREATE TABLE dbo.PriceChangeLog
(
    LogId       INT IDENTITY(1,1) PRIMARY KEY,
    ProductId   INT NOT NULL,
    OldPrice    DECIMAL(10,2) NOT NULL,
    NewPrice    DECIMAL(10,2) NOT NULL,
    ChangedAt   DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

DECLARE @ProductId INT;
DECLARE @OldPrice DECIMAL(10,2);
DECLARE @NewPrice DECIMAL(10,2);

DECLARE curFashion CURSOR FAST_FORWARD
FOR
    SELECT ProductId, Price
    FROM dbo.Products
    WHERE Category = 'Fashion';

BEGIN TRY
    BEGIN TRAN;

    OPEN curFashion;
    FETCH NEXT FROM curFashion INTO @ProductId, @OldPrice;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @NewPrice = ROUND(@OldPrice * 1.05, 2);

        UPDATE dbo.Products
        SET Price = @NewPrice
        WHERE ProductId = @ProductId;

        INSERT INTO dbo.PriceChangeLog(ProductId, OldPrice, NewPrice)
        VALUES (@ProductId, @OldPrice, @NewPrice);

        FETCH NEXT FROM curFashion INTO @ProductId, @OldPrice;
    END

    CLOSE curFashion;
    DEALLOCATE curFashion;

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF CURSOR_STATUS('global','curFashion') >= -1
    BEGIN
        CLOSE curFashion;
        DEALLOCATE curFashion;
    END

    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    THROW;
END CATCH;

SELECT * FROM dbo.Products WHERE Category='Fashion';
SELECT * FROM dbo.PriceChangeLog ORDER BY LogId;
GO




IF OBJECT_ID('dbo.usp_UpdateFashionPrice_Cursor', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_UpdateFashionPrice_Cursor;
GO

CREATE PROCEDURE dbo.usp_UpdateFashionPrice_Cursor
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable declarations
    DECLARE @ProductId INT;
    DECLARE @OldPrice DECIMAL(10,2);
    DECLARE @NewPrice DECIMAL(10,2);

    -- Cursor declaration
    DECLARE curFashion CURSOR FAST_FORWARD
    FOR
        SELECT ProductId, Price
        FROM dbo.Products
        WHERE Category = 'Fashion';

    BEGIN TRY
        BEGIN TRAN;

        -- Open cursor
        OPEN curFashion;

        FETCH NEXT FROM curFashion
        INTO @ProductId, @OldPrice;

        -- Loop through rows
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @NewPrice = ROUND(@OldPrice * 1.05, 2);

            -- Update price
            UPDATE dbo.Products
            SET Price = @NewPrice
            WHERE ProductId = @ProductId;

            -- Log change
            INSERT INTO dbo.PriceChangeLog
                (ProductId, OldPrice, NewPrice)
            VALUES
                (@ProductId, @OldPrice, @NewPrice);

            FETCH NEXT FROM curFashion
            INTO @ProductId, @OldPrice;
        END

        -- Close & cleanup cursor
        CLOSE curFashion;
        DEALLOCATE curFashion;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF CURSOR_STATUS('global','curFashion') >= -1
        BEGIN
            CLOSE curFashion;
            DEALLOCATE curFashion;
        END

        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        THROW;
    END CATCH;

    -- Show results
    SELECT *
    FROM dbo.Products
    WHERE Category = 'Fashion';

    SELECT *
    FROM dbo.PriceChangeLog
    ORDER BY LogId;
END;
GO




IF OBJECT_ID('dbo.ProductPriceAudit', 'U') IS NOT NULL
    DROP TABLE dbo.ProductPriceAudit;
GO

CREATE TABLE dbo.ProductPriceAudit
(
    AuditId    INT IDENTITY(1,1) PRIMARY KEY,
    ProductId  INT NOT NULL,
    OldPrice   DECIMAL(10,2) NULL,
    NewPrice   DECIMAL(10,2) NULL,
    ChangedAt  DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    ChangedBy  SYSNAME NULL
);
GO

IF OBJECT_ID('dbo.trg_ProductPriceAudit', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_ProductPriceAudit;
GO

CREATE TRIGGER dbo.trg_ProductPriceAudit
ON dbo.Products
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.ProductPriceAudit(ProductId, OldPrice, NewPrice, ChangedBy)
    SELECT i.ProductId, d.Price, i.Price, SUSER_SNAME()
    FROM inserted i
    INNER JOIN deleted d ON i.ProductId = d.ProductId
    WHERE ISNULL(i.Price, 0) <> ISNULL(d.Price, 0);
END;
GO

-- Test (multi-row)
UPDATE dbo.Products
SET Price = Price + 100
WHERE Category = 'Electronics';

SELECT * FROM dbo.ProductPriceAudit ORDER BY AuditId DESC;