USE ecommerce_analytics
GO

-- 6. Customer Geographic Distribution


SELECT TOP 20
    region,
    state,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct
FROM ecommerce_sales
GROUP BY region, state
ORDER BY total_sales DESC;
GO