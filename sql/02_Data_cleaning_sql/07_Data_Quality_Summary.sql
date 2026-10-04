USE ecommerce_analytics;
GO

-- 6. Data Quality Summary
-- Store summary in a temporary table

DROP TABLE IF EXISTS #DataQualitySummary;

SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id) AS unique_products,
    COUNT(DISTINCT category) AS unique_categories,
    COUNT(DISTINCT region) AS unique_regions,
    SUM(
        CASE 
            WHEN sales IS NULL 
                OR profit IS NULL 
                OR order_date IS NULL 
            THEN 1 
            ELSE 0 
        END
    ) AS records_with_nulls,
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
INTO #DataQualitySummary
FROM dbo.ecommerce_sales;


-- Convert columns into rows

SELECT
    metric,
    value
FROM #DataQualitySummary
CROSS APPLY
(
    VALUES
        ('Total Records', CAST(total_records AS VARCHAR(50))),
        ('Unique Orders', CAST(unique_orders AS VARCHAR(50))),
        ('Unique Customers', CAST(unique_customers AS VARCHAR(50))),
        ('Unique Products', CAST(unique_products AS VARCHAR(50))),
        ('Unique Categories', CAST(unique_categories AS VARCHAR(50))),
        ('Unique Regions', CAST(unique_regions AS VARCHAR(50))),
        ('Records With Nulls', CAST(records_with_nulls AS VARCHAR(50))),
        ('Earliest Order Date', CONVERT(VARCHAR(10), earliest_order_date, 23)),
        ('Latest Order Date', CONVERT(VARCHAR(10), latest_order_date, 23))
) AS unpivoted(metric, value);

GO