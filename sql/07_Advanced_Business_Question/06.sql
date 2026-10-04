USE ecommerce_analytics;
GO

-- QUESTION 6: Which products generate losses?


SELECT TOP 10
    'Loss-Making Products' AS question,
    product_name AS answer,
    SUM(profit) AS total_loss,
    COUNT(DISTINCT order_id) AS order_count
FROM ecommerce_sales
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_loss ASC;
GO
