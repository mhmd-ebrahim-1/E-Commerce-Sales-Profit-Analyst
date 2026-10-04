USE ecommerce_analytics
GO

-- 10. Customer Cohort Analysis (by Year of First Purchase)

WITH customer_cohorts AS (
    SELECT 
        customer_id,
        MIN(YEAR(order_date)) AS cohort_year
    FROM ecommerce_sales
    GROUP BY customer_id
)
SELECT 
    cc.cohort_year,
    COUNT(DISTINCT cc.customer_id) AS cohort_customers,
    SUM(es.sales) AS cohort_total_sales,
    SUM(es.profit) AS cohort_total_profit,
    (SUM(es.profit) / SUM(es.sales)) * 100 AS cohort_profit_margin_pct
FROM customer_cohorts cc
JOIN ecommerce_sales es ON cc.customer_id = es.customer_id
GROUP BY cc.cohort_year
ORDER BY cc.cohort_year;
GO
