USE ecommerce_analytics;
GO

-- 1. Monthly Sales and Profit Trend


SELECT 
    year,
    month,
    month_name,
    year_month,
    SUM(sales) AS monthly_sales,
    SUM(profit) AS monthly_profit,
    (SUM(profit) / SUM(sales)) * 100 AS monthly_profit_margin,
    COUNT(DISTINCT order_id) AS monthly_orders,
    SUM(quantity) AS monthly_quantity
FROM ecommerce_sales
GROUP BY year, month, month_name, year_month
ORDER BY year, month;
GO