USE ecommerce_analytics;
GO

-- QUESTION 29: Which customers have the highest profit margin?


SELECT TOP 10
    'Highest Profit Margin Customers' AS question,
    customer_name AS answer,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY customer_name
HAVING SUM(sales) > 0
ORDER BY profit_margin_pct DESC;
GO
