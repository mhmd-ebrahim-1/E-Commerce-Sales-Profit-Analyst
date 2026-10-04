USE ecommerce_analytics;
GO
-- QUESTION 9: Which states have negative profit?


SELECT 
    'States with Negative Profit' AS question,
    state AS answer,
    SUM(profit) AS total_loss
FROM ecommerce_sales
GROUP BY state
HAVING SUM(profit) < 0
ORDER BY total_loss ASC;
GO
