USE ecommerce_analytics;
GO

-- Insert only new fact records (avoid duplicates)
INSERT INTO dbo.fact_sales (
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    sales,
    quantity,
    discount,
    profit,
    order_to_ship_days,
    profit_margin,
    sales_per_quantity,
    discount_band
)
SELECT row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    sales,
    quantity,
    discount,
    profit,
    order_to_ship_days,
    profit_margin,
    sales_per_quantity,
    discount_band
FROM (
    SELECT 
        e.row_id,
        e.order_id,
        CAST(e.order_date AS DATE) AS order_date,
        CAST(e.ship_date AS DATE) AS ship_date,
        e.ship_mode,
        e.customer_id,
        e.product_id,
        e.sales,
        e.quantity,
        e.discount,
        e.profit,
        e.order_to_ship_days,
        e.profit_margin,
        e.sales_per_quantity,
        e.discount_band,
        ROW_NUMBER() OVER (PARTITION BY e.row_id ORDER BY e.row_id) AS rn
    FROM dbo.ecommerce_sales e
    WHERE e.customer_id IN (SELECT customer_id FROM dbo.dim_customer)
      AND e.product_id IN (SELECT product_id FROM dbo.dim_product)
      AND CAST(e.order_date AS DATE) IN (SELECT date_id FROM dbo.dim_date)
) AS ranked
WHERE rn = 1
  AND row_id NOT IN (SELECT row_id FROM dbo.fact_sales);
GO

-- Verify data
DECLARE @fact_count INT;
SELECT @fact_count = COUNT(*) FROM dbo.fact_sales;

PRINT 'fact_sales populated successfully!';
PRINT 'Total fact rows: ' + CAST(@fact_count AS VARCHAR(10));
GO

-- Sample data
SELECT TOP 5 * FROM dbo.fact_sales ORDER BY row_id;
GO

-- Verify foreign key relationships
SELECT 
    'Customer FK Check' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customers
FROM dbo.fact_sales

UNION ALL

SELECT 
    'Product FK Check' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_products
FROM dbo.fact_sales

UNION ALL

SELECT 
    'Date FK Check' AS check_type,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_dates
FROM dbo.fact_sales;
GO

-- Compare with source table
SELECT 
    'ecommerce_sales' AS table_name,
    COUNT(*) AS row_count
FROM dbo.ecommerce_sales

UNION ALL

SELECT 
    'fact_sales' AS table_name,
    COUNT(*) AS row_count
FROM dbo.fact_sales;
GO
