USE ecommerce_analytics;
GO

-- 11. Best and Worst Performing Months


WITH monthly_performance AS (
    SELECT 
        year,
        month,
        month_name,
        SUM(sales) AS monthly_sales,
        SUM(profit) AS monthly_profit,
        ROW_NUMBER() OVER (ORDER BY SUM(sales) DESC) AS sales_rank,
        ROW_NUMBER() OVER (ORDER BY SUM(profit) DESC) AS profit_rank
    FROM ecommerce_sales
    GROUP BY year, month, month_name
)
SELECT 
    'Best Sales Month' AS metric_type,
    year,
    month_name,
    '$' + FORMAT(monthly_sales, 'N2') AS value,
    sales_rank AS rank
FROM monthly_performance
WHERE sales_rank = 1

UNION ALL

SELECT 
    'Worst Sales Month',
    year,
    month_name,
    '$' + FORMAT(monthly_sales, 'N2'),
    sales_rank
FROM monthly_performance
WHERE sales_rank = (SELECT MAX(sales_rank) FROM monthly_performance)

UNION ALL

SELECT 
    'Best Profit Month',
    year,
    month_name,
    '$' + FORMAT(monthly_profit, 'N2'),
    profit_rank
FROM monthly_performance
WHERE profit_rank = 1

UNION ALL

SELECT 
    'Worst Profit Month',
    year,
    month_name,
    '$' + FORMAT(monthly_profit, 'N2'),
    profit_rank
FROM monthly_performance
WHERE profit_rank = (SELECT MAX(profit_rank) FROM monthly_performance);
GO
