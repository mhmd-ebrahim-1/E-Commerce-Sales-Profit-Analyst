USE ecommerce_analytics;
GO

-- 6. High-Sales Low-Profit Products


SELECT 
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
HAVING SUM(sales) > 1000 AND (SUM(profit) / SUM(sales)) * 100 < 5
ORDER BY total_sales DESC;
GO
