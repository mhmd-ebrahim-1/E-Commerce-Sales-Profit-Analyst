USE ecommerce_analytics;
GO

-- QUESTION 19: Which sub-categories have the highest profit margins?


SELECT TOP 10
    'Highest Profit Margin Sub-Categories' AS question,
    sub_category AS answer,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY sub_category
HAVING SUM(sales) > 0
ORDER BY profit_margin_pct DESC;
GO
