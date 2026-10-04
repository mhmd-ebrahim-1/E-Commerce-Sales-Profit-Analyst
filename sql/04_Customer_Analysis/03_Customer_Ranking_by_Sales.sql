USE ecommerce_analytics
GO

-- 3. Customer Ranking by Sales (Window Function)

WITH customer_sales AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        COUNT(DISTINCT order_id) AS total_orders
    FROM ecommerce_sales
    GROUP BY customer_id, customer_name, segment
)
SELECT TOP 20
    customer_id,
    customer_name,
    segment,
    total_sales,
    total_profit,
    total_orders,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_dense_rank,
    ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS sales_row_number
FROM customer_sales
ORDER BY total_sales DESC;
GO