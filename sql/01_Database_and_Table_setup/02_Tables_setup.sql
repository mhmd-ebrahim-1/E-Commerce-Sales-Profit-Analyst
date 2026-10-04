/*
    Database : ecommerce_analytics

    Tables:
        1. dim_customer
        2. dim_product
        3. dim_date
        4. dim_location
        5. fact_sales
        6. ecommerce_sales   

    Views:
        1. v_kpi_summary
        2. v_monthly_trends
        3. v_category_performance
        4. v_regional_performance
*/


USE ecommerce_analytics;
GO


-- 2. DROP EXISTING VIEWS

DROP VIEW IF EXISTS dbo.v_kpi_summary;
GO

DROP VIEW IF EXISTS dbo.v_monthly_trends;
GO

DROP VIEW IF EXISTS dbo.v_category_performance;
GO

DROP VIEW IF EXISTS dbo.v_regional_performance;
GO


-- DROP EXISTING TABLES

DROP TABLE IF EXISTS dbo.fact_sales;
GO

DROP TABLE IF EXISTS dbo.ecommerce_sales;
GO

DROP TABLE IF EXISTS dbo.dim_location;
GO

DROP TABLE IF EXISTS dbo.dim_customer;
GO

DROP TABLE IF EXISTS dbo.dim_product;
GO

DROP TABLE IF EXISTS dbo.dim_date;
GO


-- 4. CUSTOMER DIMENSION

CREATE TABLE dbo.dim_customer
(
    customer_id     VARCHAR(50)  NOT NULL,
    customer_name   VARCHAR(100) NULL,
    segment         VARCHAR(50)  NULL,
    country         VARCHAR(100) NULL,
    city            VARCHAR(100) NULL,
    state           VARCHAR(100) NULL,
    postal_code     VARCHAR(20)  NULL,
    region          VARCHAR(50)  NULL,

    CONSTRAINT PK_dim_customer
        PRIMARY KEY (customer_id)
);
GO


-- Customer Indexes

CREATE INDEX IX_dim_customer_segment
ON dbo.dim_customer(segment);
GO

CREATE INDEX IX_dim_customer_region
ON dbo.dim_customer(region);
GO

CREATE INDEX IX_dim_customer_state
ON dbo.dim_customer(state);
GO


-- 5. PRODUCT DIMENSION

CREATE TABLE dbo.dim_product
(
    product_id      VARCHAR(50)  NOT NULL,
    product_name    VARCHAR(200) NULL,
    category        VARCHAR(50)  NULL,
    sub_category    VARCHAR(50)  NULL,

    CONSTRAINT PK_dim_product
        PRIMARY KEY (product_id)
);
GO


-- Product Indexes

CREATE INDEX IX_dim_product_category
ON dbo.dim_product(category);
GO

CREATE INDEX IX_dim_product_sub_category
ON dbo.dim_product(sub_category);
GO


-- 6. DATE DIMENSION

CREATE TABLE dbo.dim_date
(
    date_id         DATE         NOT NULL,
    [year]          INT          NULL,
    [quarter]       INT          NULL,
    [month]         INT          NULL,
    month_name      VARCHAR(20)  NULL,
    [week]          INT          NULL,
    day_of_week     VARCHAR(20)  NULL,

    CONSTRAINT PK_dim_date
        PRIMARY KEY (date_id)
);
GO


-- Date Indexes

CREATE INDEX IX_dim_date_year
ON dbo.dim_date([year]);
GO

CREATE INDEX IX_dim_date_quarter
ON dbo.dim_date([quarter]);
GO

CREATE INDEX IX_dim_date_month
ON dbo.dim_date([month]);
GO


-- 7. LOCATION DIMENSION

CREATE TABLE dbo.dim_location
(
    location_id     INT IDENTITY(1,1) NOT NULL,
    country         VARCHAR(100) NULL,
    city            VARCHAR(100) NULL,
    state           VARCHAR(100) NULL,
    postal_code     VARCHAR(20)  NULL,
    region          VARCHAR(50)  NULL,

    CONSTRAINT PK_dim_location
        PRIMARY KEY (location_id)
);
GO


-- Location Indexes 

CREATE INDEX IX_dim_location_region
ON dbo.dim_location(region);
GO

CREATE INDEX IX_dim_location_state
ON dbo.dim_location(state);
GO

CREATE INDEX IX_dim_location_city
ON dbo.dim_location(city);
GO

-- 8. FACT TABLE

CREATE TABLE dbo.fact_sales
(
    row_id              INT           NOT NULL,
    order_id            VARCHAR(50)   NULL,
    order_date          DATE          NULL,
    ship_date           DATE          NULL,
    ship_mode           VARCHAR(50)   NULL,

    customer_id         VARCHAR(50)   NULL,
    product_id          VARCHAR(50)   NULL,

    sales               DECIMAL(15,2) NULL,
    quantity            INT           NULL,
    discount            DECIMAL(5,2)  NULL,
    profit              DECIMAL(15,2) NULL,

    order_to_ship_days  INT           NULL,
    profit_margin       DECIMAL(10,2) NULL,
    sales_per_quantity  DECIMAL(15,2) NULL,
    discount_band       VARCHAR(20)   NULL,

    CONSTRAINT PK_fact_sales
        PRIMARY KEY (row_id),

    CONSTRAINT FK_fact_sales_customer
        FOREIGN KEY (customer_id)
        REFERENCES dbo.dim_customer(customer_id),

    CONSTRAINT FK_fact_sales_product
        FOREIGN KEY (product_id)
        REFERENCES dbo.dim_product(product_id),

    CONSTRAINT FK_fact_sales_date
        FOREIGN KEY (order_date)
        REFERENCES dbo.dim_date(date_id)
);
GO


-- Fact Table Indexes

CREATE INDEX IX_fact_sales_order_id
ON dbo.fact_sales(order_id);
GO

CREATE INDEX IX_fact_sales_order_date
ON dbo.fact_sales(order_date);
GO

CREATE INDEX IX_fact_sales_ship_date
ON dbo.fact_sales(ship_date);
GO

CREATE INDEX IX_fact_sales_ship_mode
ON dbo.fact_sales(ship_mode);
GO

CREATE INDEX IX_fact_sales_customer_id
ON dbo.fact_sales(customer_id);
GO

CREATE INDEX IX_fact_sales_product_id
ON dbo.fact_sales(product_id);
GO

CREATE INDEX IX_fact_sales_discount_band
ON dbo.fact_sales(discount_band);
GO


-- 9. SINGLE ANALYTICAL TABLE

CREATE TABLE dbo.ecommerce_sales
(
    -- Transaction Information 

    row_id              INT           NOT NULL,
    order_id            VARCHAR(50)   NULL,
    order_date          DATE          NULL,
    ship_date           DATE          NULL,
    ship_mode           VARCHAR(50)   NULL,

    -- Customer Information

    customer_id         VARCHAR(50)   NULL,
    customer_name       VARCHAR(100)  NULL,
    segment             VARCHAR(50)   NULL,

    -- Geographic Information

    country             VARCHAR(100)  NULL,
    city                VARCHAR(100)  NULL,
    state               VARCHAR(100)  NULL,
    postal_code         VARCHAR(20)   NULL,
    region              VARCHAR(50)   NULL,

    -- Product Information

    product_id          VARCHAR(50)   NULL,
    category            VARCHAR(50)   NULL,
    sub_category        VARCHAR(50)   NULL,
    product_name        VARCHAR(200)  NULL,

    -- Sales Information 

    sales               DECIMAL(15,2) NULL,
    quantity            INT           NULL,
    discount            DECIMAL(5,2)  NULL,
    profit              DECIMAL(15,2) NULL,

    -- Date Attributes 

    [year]              INT           NULL,
    [quarter]           INT           NULL,
    [month]             INT           NULL,
    month_name          VARCHAR(20)   NULL,
    year_month          VARCHAR(10)   NULL,
    [week]               INT           NULL,
    day_of_week         VARCHAR(20)   NULL,

    -- Calculated Metrics 

    order_to_ship_days  INT           NULL,
    profit_margin       DECIMAL(10,2) NULL,
    sales_per_quantity  DECIMAL(15,2) NULL,
    discount_band       VARCHAR(20)   NULL,

    CONSTRAINT PK_ecommerce_sales
        PRIMARY KEY (row_id)
);
GO


-- 10. ANALYTICAL TABLE INDEXES

CREATE INDEX IX_ecommerce_sales_order_id
ON dbo.ecommerce_sales(order_id);
GO

CREATE INDEX IX_ecommerce_sales_order_date
ON dbo.ecommerce_sales(order_date);
GO

CREATE INDEX IX_ecommerce_sales_year
ON dbo.ecommerce_sales([year]);
GO

CREATE INDEX IX_ecommerce_sales_month
ON dbo.ecommerce_sales([month]);
GO

CREATE INDEX IX_ecommerce_sales_quarter
ON dbo.ecommerce_sales([quarter]);
GO

CREATE INDEX IX_ecommerce_sales_region
ON dbo.ecommerce_sales(region);
GO

CREATE INDEX IX_ecommerce_sales_state
ON dbo.ecommerce_sales(state);
GO

CREATE INDEX IX_ecommerce_sales_category
ON dbo.ecommerce_sales(category);
GO

CREATE INDEX IX_ecommerce_sales_segment
ON dbo.ecommerce_sales(segment);
GO

CREATE INDEX IX_ecommerce_sales_customer_id
ON dbo.ecommerce_sales(customer_id);
GO

CREATE INDEX IX_ecommerce_sales_product_id
ON dbo.ecommerce_sales(product_id);
GO

