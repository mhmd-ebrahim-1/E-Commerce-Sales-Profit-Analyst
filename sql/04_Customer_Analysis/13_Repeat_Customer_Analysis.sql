USE ecommerce_analytics
GO

-- 13. Repeat Customer Analysis


SELECT 
    'Repeat Customers' AS customer_type,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_sales
WHERE customer_id IN (
    SELECT customer_id 
    FROM ecommerce_sales 
    GROUP BY customer_id 
    HAVING COUNT(DISTINCT order_id) > 1
)

UNION ALL

SELECT 
    'One-time Customers',
    COUNT(DISTINCT customer_id),
    SUM(sales),
    SUM(profit),
    COUNT(DISTINCT order_id)
FROM ecommerce_sales
WHERE customer_id IN (
    SELECT customer_id 
    FROM ecommerce_sales 
    GROUP BY customer_id 
    HAVING COUNT(DISTINCT order_id) = 1
);
GO