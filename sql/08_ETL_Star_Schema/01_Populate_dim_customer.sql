USE ecommerce_analytics;
GO

-- Insert only new customers (avoid duplicates)
INSERT INTO dbo.dim_customer (
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region
)
SELECT customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region
FROM (
    SELECT 
        e.customer_id,
        e.customer_name,
        e.segment,
        e.country,
        e.city,
        e.state,
        CAST(e.postal_code AS VARCHAR(20)) AS postal_code,
        e.region,
        ROW_NUMBER() OVER (PARTITION BY e.customer_id ORDER BY e.customer_id) AS rn
    FROM dbo.ecommerce_sales e
    WHERE e.customer_id IS NOT NULL
) AS ranked
WHERE rn = 1
  AND customer_id NOT IN (SELECT customer_id FROM dbo.dim_customer);
GO

-- Verify data
DECLARE @customer_count INT;
SELECT @customer_count = COUNT(*) FROM dbo.dim_customer;

PRINT 'dim_customer populated successfully!';
PRINT 'Total customers: ' + CAST(@customer_count AS VARCHAR(10));
GO

-- Sample data
SELECT TOP 5 * FROM dbo.dim_customer ORDER BY customer_id;
GO
