USE ecommerce_analytics
GO
-- 7. Customer Purchase Frequency Analysis


SELECT TOP 20
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS order_count,
    MIN(order_date) AS first_purchase_date,
    MAX(order_date) AS last_purchase_date,
    DATEDIFF(day, MIN(order_date), MAX(order_date)) AS customer_lifetime_days,
    SUM(sales) AS total_lifetime_value,
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM ecommerce_sales
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT order_id) > 1
ORDER BY order_count DESC;
GO