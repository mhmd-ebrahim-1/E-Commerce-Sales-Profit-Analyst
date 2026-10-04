USE ecommerce_analytics;
GO

-- QUESTION 16: What is the average order value?


SELECT 
    'Average Order Value' AS question,
    '$' + FORMAT(SUM(sales) / COUNT(DISTINCT order_id), 'N2') AS answer
FROM ecommerce_sales;
GO
