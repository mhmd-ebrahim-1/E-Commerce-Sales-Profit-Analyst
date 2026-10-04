USE ecommerce_analytics;
GO

-- QUESTION 2: What is total profit?

SELECT 
    'Total Profit' AS question,
    '$' + FORMAT(SUM(profit), 'N2') AS answer
FROM ecommerce_sales;
GO