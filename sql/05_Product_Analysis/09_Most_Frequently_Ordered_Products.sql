USE ecommerce_analytics;
GO

-- 9. Most Frequently Ordered Products


SELECT TOP 20
    product_id,
    product_name,
    category,
    sub_category,
    COUNT(DISTINCT order_id) AS order_frequency,
    SUM(quantity) AS total_quantity_sold,
    SUM(sales) AS total_sales,
    AVG(sales) AS avg_sales_per_order
FROM ecommerce_sales
GROUP BY product_id, product_name, category, sub_category
ORDER BY order_frequency DESC;
GO
