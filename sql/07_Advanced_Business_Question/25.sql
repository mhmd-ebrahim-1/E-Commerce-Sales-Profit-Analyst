USE ecommerce_analytics;
GO

-- QUESTION 25: Which quarter has the highest sales?


SELECT TOP 1
    'Highest Sales Quarter' AS question,
    'Q' + CAST(quarter AS VARCHAR(1)) AS answer,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY quarter
ORDER BY total_sales DESC;
GO
