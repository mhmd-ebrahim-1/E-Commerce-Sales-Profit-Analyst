USE ecommerce_analytics;
GO
-- QUESTION 12: What are the bottom 10 products by profit?


SELECT TOP 10
    'Bottom 10 Products by Profit' AS question,
    product_name AS answer,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY product_name
ORDER BY total_profit ASC;
GO