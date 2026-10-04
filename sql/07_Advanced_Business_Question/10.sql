USE ecommerce_analytics;
GO

-- QUESTION 10: How does discount affect profit?


SELECT 
    'Discount vs Profit Analysis' AS question,
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '1-10%'
        WHEN discount <= 0.20 THEN '11-20%'
        WHEN discount <= 0.30 THEN '21-30%'
        ELSE '30%+'
    END AS discount_level,
    AVG(profit) AS avg_profit,
    (AVG(profit) / AVG(sales)) * 100 AS avg_profit_margin_pct
FROM ecommerce_sales
GROUP BY 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '1-10%'
        WHEN discount <= 0.20 THEN '11-20%'
        WHEN discount <= 0.30 THEN '21-30%'
        ELSE '30%+'
    END
ORDER BY discount_level;
GO
