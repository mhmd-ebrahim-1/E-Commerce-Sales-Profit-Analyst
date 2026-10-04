USE ecommerce_analytics;
GO

-- Clear tables in correct order (child tables first, then parent tables)
-- This removes all existing data to start fresh

PRINT 'Clearing fact_sales (child table)...';
DELETE FROM dbo.fact_sales;
GO

PRINT 'Clearing dim_customer...';
DELETE FROM dbo.dim_customer;
GO

PRINT 'Clearing dim_product...';
DELETE FROM dbo.dim_product;
GO

PRINT 'Clearing dim_date...';
DELETE FROM dbo.dim_date;
GO

PRINT 'Clearing dim_location...';
DELETE FROM dbo.dim_location;
GO

-- Reset identity seed for dim_location
DBCC CHECKIDENT ('dbo.dim_location', RESEED, 1);
GO

PRINT 'All tables cleared successfully!';
GO

-- Verify all tables are empty
SELECT 
    'fact_sales' AS table_name,
    COUNT(*) AS row_count
FROM dbo.fact_sales

UNION ALL

SELECT 
    'dim_customer' AS table_name,
    COUNT(*) AS row_count
FROM dbo.dim_customer

UNION ALL

SELECT 
    'dim_product' AS table_name,
    COUNT(*) AS row_count
FROM dbo.dim_product

UNION ALL

SELECT 
    'dim_date' AS table_name,
    COUNT(*) AS row_count
FROM dbo.dim_date

UNION ALL

SELECT 
    'dim_location' AS table_name,
    COUNT(*) AS row_count
FROM dbo.dim_location;
GO
