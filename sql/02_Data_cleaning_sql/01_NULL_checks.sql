USE ecommerce_analytics;
GO

-- NULL Check

SELECT 
    'NULL Value Check' AS check_type,
    'order_id' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_count,
    (SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS null_percentage
FROM ecommerce_sales

UNION ALL

SELECT 
    'NULL Value Check',
    'order_date',
    COUNT(*),
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END),
    (SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
FROM ecommerce_sales

UNION ALL

SELECT 
    'NULL Value Check',
    'customer_id',
    COUNT(*),
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END),
    (SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
FROM ecommerce_sales

UNION ALL

SELECT 
    'NULL Value Check',
    'sales',
    COUNT(*),
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END),
    (SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
FROM ecommerce_sales

UNION ALL

SELECT 
    'NULL Value Check',
    'profit',
    COUNT(*),
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END),
    (SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*))
FROM ecommerce_sales;
GO