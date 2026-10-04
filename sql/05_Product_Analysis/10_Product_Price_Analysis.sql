USE ecommerce_analytics;
GO

-- 10. Product Price Analysis (Sales per Quantity)


SELECT 
    category,
    sub_category,
    AVG(sales / quantity) AS avg_unit_price,
    MIN(sales / quantity) AS min_unit_price,
    MAX(sales / quantity) AS max_unit_price,
    STDEV(sales / quantity) AS price_std_dev
FROM ecommerce_sales
WHERE quantity > 0
GROUP BY category, sub_category
ORDER BY avg_unit_price DESC;
GO
