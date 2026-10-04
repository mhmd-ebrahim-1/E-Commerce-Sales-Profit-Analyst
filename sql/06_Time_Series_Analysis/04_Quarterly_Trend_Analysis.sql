USE ecommerce_analytics;
GO
-- 4. Quarterly Trend Analysis


SELECT 
    year,
    quarter,
    'Q' + CAST(quarter AS VARCHAR(1)) AS quarter_label,
    SUM(sales) AS quarterly_sales,
    SUM(profit) AS quarterly_profit,
    (SUM(profit) / SUM(sales)) * 100 AS quarterly_profit_margin,
    COUNT(DISTINCT order_id) AS quarterly_orders
FROM ecommerce_sales
GROUP BY year, quarter
ORDER BY year, quarter;
GO
