USE ecommerce_analytics
GO

-- 1. Top Customers by Sales

SELECT TOP 20
    customer_id,
    customer_name,
    segment,
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY customer_id, customer_name, segment, region
ORDER BY total_sales DESC;
GO