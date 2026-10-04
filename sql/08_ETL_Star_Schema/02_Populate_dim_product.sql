/*
    ETL Script: Populate dim_product from ecommerce_sales
    Database: ecommerce_analytics
    Purpose: Extract unique product data and populate dimension table
*/

USE ecommerce_analytics;
GO

-- Insert only new products (avoid duplicates)
INSERT INTO dbo.dim_product (
    product_id,
    product_name,
    category,
    sub_category
)
SELECT product_id,
    product_name,
    category,
    sub_category
FROM (
    SELECT 
        e.product_id,
        e.product_name,
        e.category,
        e.sub_category,
        ROW_NUMBER() OVER (PARTITION BY e.product_id ORDER BY e.product_id) AS rn
    FROM dbo.ecommerce_sales e
    WHERE e.product_id IS NOT NULL
) AS ranked
WHERE rn = 1
  AND product_id NOT IN (SELECT product_id FROM dbo.dim_product);
GO

-- Verify data
DECLARE @product_count INT;
SELECT @product_count = COUNT(*) FROM dbo.dim_product;

PRINT 'dim_product populated successfully!';
PRINT 'Total products: ' + CAST(@product_count AS VARCHAR(10));
GO

-- Sample data
SELECT TOP 5 * FROM dbo.dim_product ORDER BY product_id;
GO
