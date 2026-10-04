USE ecommerce_analytics;
GO

-- 7. OUTLIER DETECTION USING IQR METHOD

-- 7.1 SALES OUTLIERS
WITH sales_percentiles AS
(
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY sales)
            OVER () AS q1,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY sales)
            OVER () AS q3
    FROM dbo.ecommerce_sales
),

sales_bounds AS
(
    SELECT DISTINCT
        q1,
        q3,
        q3 - q1 AS iqr,

        q1 - 1.5 * (q3 - q1) AS lower_bound,

        q3 + 1.5 * (q3 - q1) AS upper_bound

    FROM sales_percentiles
)

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN e.sales < b.lower_bound
                OR e.sales > b.upper_bound
            THEN 1
            ELSE 0
        END
    ) AS outlier_count,

    CAST(
        SUM(
            CASE
                WHEN e.sales < b.lower_bound
                    OR e.sales > b.upper_bound
                THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS outlier_percentage

FROM dbo.ecommerce_sales AS e
CROSS JOIN sales_bounds AS b;
GO

-- 7.2 PROFIT OUTLIERS
WITH profit_percentiles AS
(
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY profit)
            OVER () AS q1,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY profit)
            OVER () AS q3

    FROM dbo.ecommerce_sales
),

profit_bounds AS
(
    SELECT DISTINCT
        q1,
        q3,
        q3 - q1 AS iqr,

        q1 - 1.5 * (q3 - q1) AS lower_bound,

        q3 + 1.5 * (q3 - q1) AS upper_bound

    FROM profit_percentiles
)

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN e.profit < b.lower_bound
                OR e.profit > b.upper_bound
            THEN 1
            ELSE 0
        END
    ) AS outlier_count,

    CAST(
        SUM(
            CASE
                WHEN e.profit < b.lower_bound
                    OR e.profit > b.upper_bound
                THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS outlier_percentage

FROM dbo.ecommerce_sales AS e
CROSS JOIN profit_bounds AS b;
GO