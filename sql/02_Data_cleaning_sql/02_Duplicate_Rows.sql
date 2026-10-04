USE ecommerce_analytics;
GO

-- check Duplicates

SELECT 
    'Duplicate Rows' AS check_type,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT row_id) AS unique_rows,
    COUNT(*) - COUNT(DISTINCT row_id) AS duplicate_count
FROM ecommerce_sales;
GO

-- Check for duplicate Order IDs (expected - one order can have multiple products)
SELECT TOP 10
    order_id,
    COUNT(*) AS product_count
FROM ecommerce_sales
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY product_count DESC;
GO