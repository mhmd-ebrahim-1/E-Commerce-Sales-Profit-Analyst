USE ecommerce_analytics;
GO

-- QUESTION 22: What is the correlation between discount and sales?

SELECT 
    'Discount vs Sales Relationship' AS question,
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '1-10%'
        WHEN discount <= 0.20 THEN '11-20%'
        WHEN discount <= 0.30 THEN '21-30%'
        ELSE '30%+'
    END AS discount_level,
    AVG(sales) AS avg_sales,
    COUNT(*) AS transaction_count
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