USE ecommerce_analytics;
GO

-- QUESTION 3: What is overall profit margin?


SELECT 
    'Overall Profit Margin' AS question,
    FORMAT((SUM(profit) / SUM(sales)) * 100, 'N2') + '%' AS answer
FROM ecommerce_sales;
GO
