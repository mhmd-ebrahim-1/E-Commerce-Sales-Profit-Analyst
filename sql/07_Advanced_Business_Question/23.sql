USE ecommerce_analytics;
GO

-- QUESTION 23: Which products are most frequently ordered?


SELECT TOP 10
    'Most Frequently Ordered Products' AS question,
    product_name AS answer,
    COUNT(DISTINCT order_id) AS order_frequency,
    SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY product_name
ORDER BY order_frequency DESC;
GO