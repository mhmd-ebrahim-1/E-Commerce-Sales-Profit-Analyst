USE ecommerce_analytics;
GO

-- 4. Category Performance


SELECT 
    category,
    COUNT(DISTINCT product_id) AS unique_products,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    SUM(sales) / COUNT(DISTINCT product_id) AS avg_sales_per_product
FROM ecommerce_sales
GROUP BY category
ORDER BY total_sales DESC;
GO
