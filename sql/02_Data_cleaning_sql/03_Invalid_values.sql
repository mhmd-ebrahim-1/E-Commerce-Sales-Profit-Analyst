USE ecommerce_analytics;
GO

-- 3. Invalid Values

-- Check for negative Sales (should be positive or zero)
SELECT 
    'Negative Sales' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN sales < 0 THEN 1 ELSE 0 END) AS negative_count,
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales
FROM ecommerce_sales;
GO

-- Check for negative Quantity (should be positive)
SELECT 
    'Negative Quantity' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN quantity < 0 THEN 1 ELSE 0 END) AS negative_count,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity
FROM ecommerce_sales;
GO

-- Check for Discount outside valid range (0-1)
SELECT 
    'Invalid Discount' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN discount < 0 OR discount > 1 THEN 1 ELSE 0 END) AS invalid_count,
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount
FROM ecommerce_sales;
GO

-- Check for Ship Date before Order Date
SELECT 
    'Invalid Date Sequence' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END) AS invalid_count
FROM ecommerce_sales;
GO