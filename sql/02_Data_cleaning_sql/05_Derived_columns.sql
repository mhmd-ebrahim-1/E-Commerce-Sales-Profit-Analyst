USE ecommerce_analytics;
GO

-- 5. Derived Columns


-- Calculate Profit Margin
SELECT TOP 10
    order_id,
    product_name,
    sales,
    profit,
    (profit / sales) * 100 AS profit_margin_pct
FROM ecommerce_sales
WHERE sales > 0;
GO

-- Calculate Sales per Quantity
SELECT TOP 10
    order_id,
    product_name,
    sales,
    quantity,
    sales / quantity AS sales_per_quantity
FROM ecommerce_sales
WHERE quantity > 0;
GO

-- Create Discount Bands
SELECT TOP 10
    order_id,
    discount,
    CASE 
        WHEN discount = 0 THEN '0%'
        WHEN discount <= 0.10 THEN '1-10%'
        WHEN discount <= 0.20 THEN '11-20%'
        WHEN discount <= 0.30 THEN '21-30%'
        ELSE '30%+'
    END AS discount_band
FROM ecommerce_sales;
GO
