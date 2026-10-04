USE ecommerce_analytics;
GO

-- 15. Product Discount Impact Analysis



SELECT 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN 'Low Discount (1-10%)'
        WHEN discount <= 0.20 THEN 'Medium Discount (11-20%)'
        WHEN discount <= 0.30 THEN 'High Discount (21-30%)'
        ELSE 'Very High Discount (30%+)'
    END AS discount_level,
    COUNT(DISTINCT product_id) AS unique_products,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    (SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
    AVG(quantity) AS avg_quantity_per_order
FROM ecommerce_sales
GROUP BY 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN 'Low Discount (1-10%)'
        WHEN discount <= 0.20 THEN 'Medium Discount (11-20%)'
        WHEN discount <= 0.30 THEN 'High Discount (21-30%)'
        ELSE 'Very High Discount (30%+)'
    END
ORDER BY 
    CASE 
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN 'Low Discount (1-10%)'
        WHEN discount <= 0.20 THEN 'Medium Discount (11-20%)'
        WHEN discount <= 0.30 THEN 'High Discount (21-30%)'
        ELSE 'Very High Discount (30%+)'
    END;
GO
