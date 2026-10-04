/*
    ETL Script: Populate dim_location from ecommerce_sales
    Database: ecommerce_analytics
    Purpose: Extract unique location data and populate dimension table
*/

USE ecommerce_analytics;
GO

-- Insert only new locations (avoid duplicates)
INSERT INTO dbo.dim_location (
    country,
    city,
    state,
    postal_code,
    region
)
SELECT country,
    city,
    state,
    postal_code,
    region
FROM (
    SELECT DISTINCT
        e.country,
        e.city,
        e.state,
        CAST(e.postal_code AS VARCHAR(20)) AS postal_code,
        e.region,
        ROW_NUMBER() OVER (PARTITION BY e.city, e.state, CAST(e.postal_code AS VARCHAR(20)) ORDER BY e.city) AS rn
    FROM dbo.ecommerce_sales e
    WHERE e.city IS NOT NULL
) AS ranked
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM dbo.dim_location d 
      WHERE d.city = ranked.city 
        AND d.state = ranked.state 
        AND d.postal_code = ranked.postal_code
  );
GO

-- Verify data
DECLARE @location_count INT;
SELECT @location_count = COUNT(*) FROM dbo.dim_location;

PRINT 'dim_location populated successfully!';
PRINT 'Total unique locations: ' + CAST(@location_count AS VARCHAR(10));
GO

-- Sample data
SELECT TOP 5 * FROM dbo.dim_location ORDER BY location_id;
GO

-- Location breakdown by region
SELECT 
    region,
    COUNT(*) AS location_count
FROM dbo.dim_location
GROUP BY region
ORDER BY region;
GO
