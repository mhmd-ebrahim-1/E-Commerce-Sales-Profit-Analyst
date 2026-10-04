USE ecommerce_analytics
GO

-- 14. Customer Average Order Value by Segment


SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales,
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value,
    SUM(sales) / COUNT(DISTINCT customer_id) AS avg_revenue_per_customer,
    MIN(SUM(sales) / COUNT(DISTINCT order_id)) OVER () AS min_aov,
    MAX(SUM(sales) / COUNT(DISTINCT order_id)) OVER () AS max_aov
FROM ecommerce_sales
GROUP BY segment
ORDER BY avg_order_value DESC;
GO
