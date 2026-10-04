USE ecommerce_analytics;
GO

-- 7. Products with High Discount and Negative Profit


SELECT 
    product_id,
    product_name,
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(discount) * 100 AS avg_discount_pct,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS order_count
FROM ecommerce_sales
GROUP BY product_id, product_name, category, sub_category
HAVING SUM(profit) < 0 AND AVG(discount) > 0.2
ORDER BY total_profit ASC;
GO
