USE ecommerce_analytics;
GO

-- 3. Bottom 10 Products by Profit (Loss-Making)


SELECT TOP 10
    product_id,
    product_name,
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS order_count
FROM ecommerce_sales
GROUP BY product_id, product_name, category, sub_category
ORDER BY total_profit ASC;
GO