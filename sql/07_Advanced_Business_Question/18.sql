USE ecommerce_analytics;
GO

-- QUESTION 18: What is the average shipping time?


SELECT 
    'Average Shipping Time' AS question,
    FORMAT(AVG(order_to_ship_days), 'N1') + ' days' AS answer
FROM ecommerce_sales;
GO