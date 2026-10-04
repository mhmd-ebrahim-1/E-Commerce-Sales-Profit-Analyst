USE ecommerce_analytics
GO

-- 12. Customer Share of Wallet (Top Customers)


WITH customer_totals AS (
    SELECT 
        customer_id,
        customer_name,
        SUM(sales) AS customer_sales
    FROM ecommerce_sales
    GROUP BY customer_id, customer_name
),
customer_share AS (
    SELECT 
        customer_id,
        customer_name,
        customer_sales,
        SUM(customer_sales) OVER () AS total_sales,
        SUM(customer_sales) OVER (
            ORDER BY customer_sales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_sales
    FROM customer_totals
)
SELECT TOP 20
    customer_id,
    customer_name,
    '$' + FORMAT(customer_sales, 'N2') AS customer_sales,
    FORMAT(
        customer_sales * 100.0 / NULLIF(total_sales, 0),
        'N2'
    ) + '%' AS share_percentage,
    FORMAT(
        cumulative_sales * 100.0 / NULLIF(total_sales, 0),
        'N2'
    ) + '%' AS cumulative_percentage
FROM customer_share
ORDER BY customer_sales DESC;
GO