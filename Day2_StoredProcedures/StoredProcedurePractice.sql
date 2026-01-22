USE [master]
GO
/****** Object:  Database [StoredProcedurePractice]    Script Date: 22-01-2026 14:20:05 ******/
CREATE DATABASE [StoredProcedurePractice]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StoredProcedurePractice', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\StoredProcedurePractice.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StoredProcedurePractice_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\StoredProcedurePractice_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [StoredProcedurePractice] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StoredProcedurePractice].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StoredProcedurePractice] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET ARITHABORT OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [StoredProcedurePractice] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StoredProcedurePractice] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StoredProcedurePractice] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET  ENABLE_BROKER 
GO
ALTER DATABASE [StoredProcedurePractice] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StoredProcedurePractice] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StoredProcedurePractice] SET  MULTI_USER 
GO
ALTER DATABASE [StoredProcedurePractice] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StoredProcedurePractice] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StoredProcedurePractice] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StoredProcedurePractice] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StoredProcedurePractice] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [StoredProcedurePractice] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [StoredProcedurePractice] SET QUERY_STORE = ON
GO
ALTER DATABASE [StoredProcedurePractice] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [StoredProcedurePractice]
GO
/****** Object:  Table [dbo].[BankAccount]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccount](
	[AccountNo] [int] NOT NULL,
	[AccountHolderName] [varchar](50) NOT NULL,
	[Balance] [decimal](12, 2) NOT NULL,
	[AccountType] [varchar](20) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmpId] [int] NOT NULL,
	[EmpName] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
	[BasicSalary] [decimal](10, 2) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddEmployee]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddEmployee]
	@EmpId int,
	@EmpName varchar(50),
	@Department varchar(50),
	@BasicSalary decimal(9,2),
	@IsActive BIT
As
Begin
INSERT INTO Employees(EmpId, EmpName, Department, BasicSalary, IsActive)
VALUES (@EmpId, @EmpName, @Department, @BasicSalary, @IsActive);
END
GO
/****** Object:  StoredProcedure [dbo].[DepositAmount]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
-- STEP 5: PROCEDURE - DEPOSIT AMOUNT
---------------------------------------------------------------
CREATE   PROCEDURE [dbo].[DepositAmount]
    @AccountNo     INT,
    @DepositAmount DECIMAL(12,2)
AS
BEGIN
    UPDATE dbo.BankAccount
    SET Balance = Balance + @DepositAmount
    WHERE AccountNo = @AccountNo
      AND IsActive = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAccountDetails]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
-- STEP 4: PROCEDURE - GET ACCOUNT DETAILS
---------------------------------------------------------------
CREATE   PROCEDURE [dbo].[GetAccountDetails]
    @AccountNo INT
AS
BEGIN
    SELECT *
    FROM dbo.BankAccount
    WHERE AccountNo = @AccountNo;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployees]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllEmployees]

AS
BEGIN
	SELECT * FROM Employees
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeCountByDepartment]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployeeCountByDepartment]
	@Department varchar(50),
	@EmpCount INT OUTPUT
As
Begin
SELECT @EmpCount = COUNT(*)
	FROM Employees
	WHERE Department = @Department
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeesByDepartment]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEmployeesByDepartment]
	@Department varchar(50)
As
Begin
SELECT * FROM Employees WHERE Department = @Department
End
GO
/****** Object:  StoredProcedure [dbo].[WithdrawAmount]    Script Date: 22-01-2026 14:20:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------
-- STEP 6: PROCEDURE - WITHDRAW AMOUNT (WITH VALIDATION)
---------------------------------------------------------------
CREATE   PROCEDURE [dbo].[WithdrawAmount]
    @AccountNo      INT,
    @WithdrawAmount DECIMAL(12,2)
AS
BEGIN
    -- Withdraw only if sufficient balance and active account
    UPDATE dbo.BankAccount
    SET Balance = Balance - @WithdrawAmount
    WHERE AccountNo = @AccountNo
      AND IsActive = 1
      AND Balance >= @WithdrawAmount;
END;
GO
USE [master]
GO
ALTER DATABASE [StoredProcedurePractice] SET  READ_WRITE 
GO