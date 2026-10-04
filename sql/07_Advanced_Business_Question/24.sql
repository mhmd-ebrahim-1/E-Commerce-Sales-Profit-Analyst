USE ecommerce_analytics;
GO

-- QUESTION 24: What is the customer retention rate?


WITH customer_orders AS (
    SELECT 
        customer_id,
        MIN(YEAR(order_date)) AS first_year,
        MAX(YEAR(order_date)) AS last_year,
        COUNT(DISTINCT YEAR(order_date)) AS years_purchased
    FROM ecommerce_sales
    GROUP BY customer_id
)
SELECT 
    'Customer Retention Rate' AS question,
    FORMAT((SUM(CASE WHEN years_purchased > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 'N2') + '%' AS answer
FROM customer_orders;
GO