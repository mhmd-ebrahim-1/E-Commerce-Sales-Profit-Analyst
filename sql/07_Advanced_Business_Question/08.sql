USE ecommerce_analytics;
GO

-- QUESTION 8: Which region is most profitable?


SELECT TOP 1
    'Most Profitable Region' AS question,
    region AS answer,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY region
ORDER BY total_profit DESC;
GO
