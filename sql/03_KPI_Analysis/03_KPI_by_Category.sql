USE ecommerce_analytics;
GO

-- KPIs by Category

SELECT 
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY category
ORDER BY total_sales DESC;
GO