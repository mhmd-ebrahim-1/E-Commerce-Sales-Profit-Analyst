USE ecommerce_analytics;
GO

-- 15. Customer Profit Margin Distribution


WITH customer_margin AS (
    SELECT 
        customer_id,
        SUM(sales) AS sales,
        SUM(profit) AS profit,
        (
            SUM(profit) * 100.0 /
            NULLIF(SUM(sales), 0)
        ) AS profit_margin_pct
    FROM ecommerce_sales
    GROUP BY customer_id
),
margin_distribution AS (
    SELECT 
        customer_id,
        sales,
        profit,
        CASE 
            WHEN profit_margin_pct >= 20 THEN 'High Margin (20%+)'
            WHEN profit_margin_pct >= 10 THEN 'Medium Margin (10-19%)'
            WHEN profit_margin_pct >= 0 THEN 'Low Margin (0-9%)'
            ELSE 'Negative Margin'
        END AS margin_category
    FROM customer_margin
)
SELECT 
    margin_category,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM margin_distribution
GROUP BY margin_category
ORDER BY 
    CASE margin_category
        WHEN 'High Margin (20%+)' THEN 1
        WHEN 'Medium Margin (10-19%)' THEN 2
        WHEN 'Low Margin (0-9%)' THEN 3
        WHEN 'Negative Margin' THEN 4
    END;
GO