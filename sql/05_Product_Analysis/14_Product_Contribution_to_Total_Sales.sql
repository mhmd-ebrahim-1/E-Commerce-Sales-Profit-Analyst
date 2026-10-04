USE ecommerce_analytics;
GO

-- 14. Product Contribution to Total Sales


WITH product_totals AS (
    SELECT 
        product_id,
        product_name,
        category,
        SUM(sales) AS product_sales
    FROM ecommerce_sales
    GROUP BY product_id, product_name, category
),
product_contribution AS (
    SELECT 
        product_id,
        product_name,
        category,
        product_sales,
        SUM(product_sales) OVER () AS total_sales,
        SUM(product_sales) OVER (
            ORDER BY product_sales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_sales
    FROM product_totals
)
SELECT TOP 20
    product_id,
    product_name,
    category,
    '$' + FORMAT(product_sales, 'N2') AS product_sales,
    FORMAT(
        product_sales * 100.0 / NULLIF(total_sales, 0),
        'N2'
    ) + '%' AS sales_contribution_pct,
    FORMAT(
        cumulative_sales * 100.0 / NULLIF(total_sales, 0),
        'N2'
    ) + '%' AS cumulative_contribution_pct
FROM product_contribution
ORDER BY product_sales DESC;
GO