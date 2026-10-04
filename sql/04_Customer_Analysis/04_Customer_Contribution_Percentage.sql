USE ecommerce_analytics;
GO

-- 4. Customer Contribution Percentage

WITH customer_totals AS (
    SELECT 
        customer_id,
        customer_name,
        SUM(sales) AS customer_sales
    FROM ecommerce_sales
    GROUP BY customer_id, customer_name
),
customer_contribution AS (
    SELECT 
        customer_id,
        customer_name,
        customer_sales,
        SUM(customer_sales) OVER () AS total_company_sales,
        (customer_sales * 100.0 / 
            NULLIF(SUM(customer_sales) OVER (), 0)
        ) AS sales_contribution_pct,
        SUM(customer_sales) OVER (
            ORDER BY customer_sales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales
    FROM customer_totals
),
customer_final AS (
    SELECT 
        customer_id,
        customer_name,
        customer_sales,
        sales_contribution_pct,
        running_sales,
        (running_sales * 100.0 /
            NULLIF(SUM(customer_sales) OVER (), 0)
        ) AS running_contribution_pct
    FROM customer_contribution
)
SELECT TOP 20
    customer_id,
    customer_name,
    '$' + FORMAT(customer_sales, 'N2') AS customer_sales,
    FORMAT(sales_contribution_pct, 'N2') + '%' AS contribution_pct,
    FORMAT(running_contribution_pct, 'N2') + '%' AS cumulative_contribution_pct
FROM customer_final
ORDER BY customer_sales DESC;
GO