USE ecommerce_analytics
GO
-- 8. High-Value Customer Analysis (Top 10% by Sales)


WITH customer_sales AS (
    SELECT 
        customer_id,
        customer_name,
        SUM(sales) AS total_sales,
        PERCENT_RANK() OVER (ORDER BY SUM(sales)) AS sales_percentile
    FROM ecommerce_sales
    GROUP BY customer_id, customer_name
)
SELECT 
    customer_id,
    customer_name,
    '$' + FORMAT(total_sales, 'N2') AS total_sales,
    FORMAT(sales_percentile * 100, 'N1') + '%' AS percentile
FROM customer_sales
WHERE sales_percentile >= 0.90
ORDER BY total_sales DESC;
GO
