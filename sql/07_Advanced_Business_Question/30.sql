USE ecommerce_analytics;
GO

-- QUESTION 30: What is the trend of profit margin over time?


SELECT 
    'Profit Margin Trend' AS question,
    year_month AS period,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct
FROM ecommerce_sales
GROUP BY year_month
ORDER BY year_month;
GO
