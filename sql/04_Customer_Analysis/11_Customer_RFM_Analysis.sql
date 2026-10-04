USE ecommerce_analytics
GO

-- 11. Customer RFM Analysis (Recency, Frequency, Monetary)


WITH customer_rfm AS (
    SELECT 
        customer_id,
        customer_name,
        DATEDIFF(day, MAX(order_date), GETDATE()) AS recency_days,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(sales) AS monetary
    FROM ecommerce_sales
    GROUP BY customer_id, customer_name
),
rfm_scores AS (
    SELECT 
        customer_id,
        customer_name,
        recency_days,
        frequency,
        monetary,
        NTILE(4) OVER (ORDER BY recency_days ASC) AS recency_score,
        NTILE(4) OVER (ORDER BY frequency DESC) AS frequency_score,
        NTILE(4) OVER (ORDER BY monetary DESC) AS monetary_score
    FROM customer_rfm
)
SELECT TOP 20
    customer_id,
    customer_name,
    recency_days,
    frequency,
    '$' + FORMAT(monetary, 'N2') AS monetary_value,
    recency_score,
    frequency_score,
    monetary_score,
    CAST(recency_score AS VARCHAR(1)) + CAST(frequency_score AS VARCHAR(1)) + CAST(monetary_score AS VARCHAR(1)) AS rfm_segment
FROM rfm_scores
ORDER BY monetary DESC;
GO
