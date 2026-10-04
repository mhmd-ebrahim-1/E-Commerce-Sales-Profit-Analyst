USE ecommerce_analytics;
GO

-- QUESTION 21: Which city has the highest sales?


SELECT TOP 1
    'Highest Sales City' AS question,
    city AS answer,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY city
ORDER BY total_sales DESC;
GO
