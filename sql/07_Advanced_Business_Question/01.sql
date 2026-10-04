USE ecommerce_analytics;
GO

-- QUESTION 1: What is total revenue?


SELECT 
    'Total Revenue' AS question,
    '$' + FORMAT(SUM(sales), 'N2') AS answer
FROM ecommerce_sales;
GO