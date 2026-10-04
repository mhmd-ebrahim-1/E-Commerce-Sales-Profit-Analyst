USE ecommerce_analytics;
GO

-- QUESTION 5: Which category generates the most profit?


SELECT TOP 1
    'Top Profit Category' AS question,
    category AS answer,
    SUM(profit) AS profit
FROM ecommerce_sales
GROUP BY category
ORDER BY profit DESC;
GO
