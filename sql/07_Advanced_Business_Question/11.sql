USE ecommerce_analytics;
GO

-- QUESTION 11: What are the top 10 products by sales?


SELECT TOP 10
    'Top 10 Products by Sales' AS question,
    product_name AS answer,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY product_name
ORDER BY total_sales DESC;
GO
