USE ecommerce_analytics
GO

-- 5. Customer Segment Analysis

SELECT 
    segment,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) / COUNT(DISTINCT customer_id) AS avg_revenue_per_customer,
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value,
    COUNT(DISTINCT order_id) / COUNT(DISTINCT customer_id) AS avg_orders_per_customer
FROM ecommerce_sales
GROUP BY segment
ORDER BY total_sales DESC;
GO