/*
    ETL Script: Populate dim_date from ecommerce_sales
    Database: ecommerce_analytics
    Purpose: Extract unique dates and populate date dimension table
*/

USE ecommerce_analytics;
GO

-- Insert only new dates (avoid duplicates)
INSERT INTO dbo.dim_date (
    date_id,
    [year],
    [quarter],
    [month],
    month_name,
    [week],
    day_of_week
)
SELECT date_id,
    [year],
    [quarter],
    [month],
    month_name,
    [week],
    day_of_week
FROM (
    SELECT DISTINCT
        CAST(e.order_date AS DATE) AS date_id,
        YEAR(e.order_date) AS [year],
        DATEPART(QUARTER, e.order_date) AS [quarter],
        MONTH(e.order_date) AS [month],
        DATENAME(MONTH, e.order_date) AS month_name,
        DATEPART(WEEK, e.order_date) AS [week],
        DATENAME(WEEKDAY, e.order_date) AS day_of_week
    FROM dbo.ecommerce_sales e
    WHERE e.order_date IS NOT NULL
    
    UNION
    
    SELECT DISTINCT
        CAST(e.ship_date AS DATE) AS date_id,
        YEAR(e.ship_date) AS [year],
        DATEPART(QUARTER, e.ship_date) AS [quarter],
        MONTH(e.ship_date) AS [month],
        DATENAME(MONTH, e.ship_date) AS month_name,
        DATEPART(WEEK, e.ship_date) AS [week],
        DATENAME(WEEKDAY, e.ship_date) AS day_of_week
    FROM dbo.ecommerce_sales e
    WHERE e.ship_date IS NOT NULL
) AS dates
WHERE date_id NOT IN (SELECT date_id FROM dbo.dim_date);
GO

-- Verify data
DECLARE @date_count INT;
SELECT @date_count = COUNT(*) FROM dbo.dim_date;

PRINT 'dim_date populated successfully!';
PRINT 'Total unique dates: ' + CAST(@date_count AS VARCHAR(10));
GO

-- Sample data
SELECT TOP 5 * FROM dbo.dim_date ORDER BY date_id;
GO

-- Date range verification
SELECT 
    MIN(date_id) AS first_date,
    MAX(date_id) AS last_date,
    COUNT(*) AS total_dates
FROM dbo.dim_date;
GO
