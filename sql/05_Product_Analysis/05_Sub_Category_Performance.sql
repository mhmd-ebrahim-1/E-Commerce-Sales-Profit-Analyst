USE ecommerce_analytics;
GO

-- 5. Sub-Category Performance


SELECT 
    category,
    sub_category,
    COUNT(DISTINCT product_id) AS unique_products,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY category, sub_category
ORDER BY total_sales DESC;
GO
