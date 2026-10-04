USE ecommerce_analytics;
GO

-- 8. Product Profitability Matrix (BCG Analysis Style)


WITH product_stats AS (
    SELECT 
        product_id,
        product_name,
        category,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit,
        (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct
    FROM ecommerce_sales
    GROUP BY product_id, product_name, category
),
quartiles AS (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_sales) OVER () AS sales_median,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_profit) OVER () AS profit_median
    FROM product_stats
)
SELECT TOP 20
    ps.product_id,
    ps.product_name,
    ps.category,
    ps.total_sales,
    ps.total_profit,
    ps.profit_margin_pct,
    CASE 
        WHEN ps.total_sales >= (SELECT TOP 1 sales_median FROM quartiles) 
                AND ps.total_profit >= (SELECT TOP 1 profit_median FROM quartiles) 
        THEN 'Star (High Sales, High Profit)'
        WHEN ps.total_sales >= (SELECT TOP 1 sales_median FROM quartiles) 
                AND ps.total_profit < (SELECT TOP 1 profit_median FROM quartiles) 
        THEN 'Cash Cow (High Sales, Low Profit)'
        WHEN ps.total_sales < (SELECT TOP 1 sales_median FROM quartiles) 
                AND ps.total_profit >= (SELECT TOP 1 profit_median FROM quartiles) 
        THEN 'Question Mark (Low Sales, High Profit)'
        ELSE 'Dog (Low Sales, Low Profit)'
    END AS bcg_quadrant
FROM product_stats ps, quartiles
ORDER BY ps.total_sales DESC;
GO
