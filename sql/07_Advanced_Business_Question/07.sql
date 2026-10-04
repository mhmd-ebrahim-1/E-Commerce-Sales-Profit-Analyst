USE ecommerce_analytics;
GO

-- QUESTION 7: Which customers generate the most revenue?


SELECT TOP 10
    'Top Revenue Customers' AS question,
    customer_name AS answer,
    SUM(sales) AS total_revenue
FROM ecommerce_sales
GROUP BY customer_name
ORDER BY total_revenue DESC;
GO
