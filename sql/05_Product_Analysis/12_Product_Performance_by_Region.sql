USE ecommerce_analytics;
GO

-- 12. Product Performance by Region


SELECT TOP 30
    product_id,
    product_name,
    category,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS order_count
FROM ecommerce_sales
GROUP BY product_id, product_name, category, region
ORDER BY product_id, total_sales DESC;
GO
