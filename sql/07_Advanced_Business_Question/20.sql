USE ecommerce_analytics;
GO

-- QUESTION 20: What percentage of orders are loss-making?


SELECT 
    'Loss-Making Order Percentage' AS question,
    FORMAT((SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2') + '%' AS answer
FROM ecommerce_sales;
GO
