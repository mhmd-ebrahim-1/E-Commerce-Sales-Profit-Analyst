USE ecommerce_analytics;
GO

-- QUESTION 26: What is the average discount given?


SELECT 
    'Average Discount' AS question,
    FORMAT(AVG(discount) * 100, 'N2') + '%' AS answer
FROM ecommerce_sales;
GO
