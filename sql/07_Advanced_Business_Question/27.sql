USE ecommerce_analytics;
GO

-- QUESTION 27: Which products have the highest quantity sold?


SELECT TOP 10
    'Highest Quantity Products' AS question,
    product_name AS answer,
    SUM(quantity) AS total_quantity,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY product_name
ORDER BY total_quantity DESC;
GO
