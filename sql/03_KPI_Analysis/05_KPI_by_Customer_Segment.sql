USE ecommerce_analytics;
GO

-- KPIs by Customer Segment

SELECT 
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(sales) / COUNT(DISTINCT customer_id) AS avg_revenue_per_customer
FROM ecommerce_sales
GROUP BY segment
ORDER BY total_sales DESC;
GO