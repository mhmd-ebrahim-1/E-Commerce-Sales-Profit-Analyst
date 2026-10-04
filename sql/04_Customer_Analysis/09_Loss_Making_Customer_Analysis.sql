USE ecommerce_analytics
GO
-- 9. Loss-Making Customer Analysis

SELECT TOP 20
    customer_id,
    customer_name,
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_orders
FROM ecommerce_sales
GROUP BY customer_id, customer_name, segment
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;
GO