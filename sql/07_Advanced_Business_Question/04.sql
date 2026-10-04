USE ecommerce_analytics;
GO
-- QUESTION 4: Which category generates the most revenue?


SELECT TOP 1
    'Top Revenue Category' AS question,
    category AS answer,
    SUM(sales) AS revenue
FROM ecommerce_sales
GROUP BY category
ORDER BY revenue DESC;
GO
