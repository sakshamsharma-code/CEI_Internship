-- ============================================================
--  Celebal Excellence Internship 2026 — Week 2 SQL Assignment
--  Superstore Sales Data Analysis
--  Submitted By: Saksham Sharma
--  Dataset: Sample - Superstore.csv (9,994 rows x 21 columns)
--  Database: MySQL
-- ============================================================


-- ============================================================
-- STEP 1: LOAD DATASET INTO SQL DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;

CREATE TABLE superstore (
    row_id        INT,
    order_id      VARCHAR(20),
    order_date    DATE,
    ship_date     DATE,
    ship_mode     VARCHAR(30),
    customer_id   VARCHAR(20),
    customer_name VARCHAR(50),
    segment       VARCHAR(20),
    country       VARCHAR(30),
    city          VARCHAR(50),
    state         VARCHAR(30),
    postal_code   INT,
    region        VARCHAR(20),
    product_id    VARCHAR(20),
    category      VARCHAR(30),
    sub_category  VARCHAR(30),
    product_name  VARCHAR(200),
    sales         DECIMAL(10,4),
    quantity      INT,
    discount      DECIMAL(5,2),
    profit        DECIMAL(10,4)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    row_id, order_id, @order_date, @ship_date, ship_mode, customer_id,
    customer_name, segment, country, city, state, postal_code, region,
    product_id, category, sub_category, product_name, sales, quantity, discount, profit
)
SET
    order_date = STR_TO_DATE(@order_date, '%m/%d/%Y'),
    ship_date  = STR_TO_DATE(@ship_date,  '%m/%d/%Y');
-- Output: 9994 row(s) affected. Records: 9994 Deleted: 0 Skipped: 0 Warnings: 0


-- ============================================================
-- STEP 2: EXPLORE TABLE (Schema & Sample Data)
-- ============================================================

-- 2.1 Table Structure
DESCRIBE superstore;
-- Output: Displays all 21 columns with field names, data types, and null/key/default info.

-- 2.2 Sample Data — First 5 Rows
SELECT * FROM superstore LIMIT 5;
-- Output: Returns 5 rows showing order details, customer info, product, sales, quantity, discount, profit.

-- 2.3 Row Count & Distinct Values

-- Total row count
SELECT COUNT(*) AS total_rows FROM superstore;
-- Output: total_rows = 9994

-- Distinct regions
SELECT DISTINCT region FROM superstore;
-- Output: South, West, Central, East

-- Distinct categories
SELECT DISTINCT category FROM superstore;
-- Output: Furniture, Office Supplies, Technology

-- Distinct segments
SELECT DISTINCT segment FROM superstore;
-- Output: Consumer, Corporate, Home Office

-- Distinct ship modes
SELECT DISTINCT ship_mode FROM superstore;
-- Output: Second Class, Standard Class, First Class, Same Day


-- ============================================================
-- STEP 3: APPLY WHERE FILTERS (Region, Category, Date, Sales)
-- ============================================================

-- 3.1 Filter by Region = 'West'
SELECT order_id, order_date, customer_name, region, ROUND(sales, 2) AS sales
FROM superstore
WHERE region = 'West'
LIMIT 8;
-- Output: Returns 8 West region orders — includes Darrin Van Huff, Brosina Hoffman with sales from 7.28 to 1706.18.

-- 3.2 Filter by Category = 'Technology'
SELECT product_name, category, ROUND(sales, 2) AS sales, ROUND(profit, 2) AS profit
FROM superstore
WHERE category = 'Technology'
LIMIT 8;
-- Output: Returns 8 Technology products — Mitel IP Phone (907.15), Konftel Phone (911.42), GE 30524EE4 (1097.54).

-- 3.3 Filter by Sales > $1,000 (High-Value Orders)
SELECT order_id, customer_name, product_name, ROUND(sales, 2) AS sales
FROM superstore
WHERE sales > 1000
ORDER BY sales DESC
LIMIT 8;
-- Output: Cisco TelePresence EX90 tops at $22,638.48 (Sean Miller); Canon Copier appears 4 times in top 8.

-- 3.4 Filter by Year 2017
SELECT COUNT(*) AS orders_2017
FROM superstore
WHERE YEAR(order_date) = 2017;
-- Output: orders_2017 = 3312

-- 3.5 Filter by High Discount > 0.3 (Loss-Causing Orders)
SELECT order_id, product_name, category,
       ROUND(discount, 2) AS discount,
       ROUND(profit, 2)   AS profit
FROM superstore
WHERE discount > 0.3
ORDER BY discount DESC
LIMIT 8;
-- Output: All 8 results have discount = 0.80 with negative profit — highest loss is -453.85 (Kensington Power Center).


-- ============================================================
-- STEP 4: GROUP BY AGGREGATIONS (Sales, Quantity, Averages)
-- ============================================================

-- 4.1 Total Sales, Quantity and Average Sales by Region
SELECT region,
       ROUND(SUM(sales), 2)  AS total_sales,
       SUM(quantity)         AS total_quantity,
       ROUND(AVG(sales), 2)  AS avg_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
-- Output: West 725457.82 (12266 qty, avg 226.49) | East 678781.24 | Central 501239.89 | South 391721.91 (avg 241.80)

-- 4.2 Total Sales, Profit and Average Discount by Category
SELECT category,
       ROUND(SUM(sales), 2)        AS total_sales,
       ROUND(SUM(profit), 2)       AS total_profit,
       ROUND(AVG(discount)*100, 1) AS avg_discount_pct
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;
-- Output: Technology 836154.03 / 145454.95 / 13.2% | Furniture 741999.80 / 18451.27 / 17.4% | Office Supplies 719047.03 / 122490.80 / 15.7%

-- 4.3 Total Sales and Profit by Sub-Category
SELECT sub_category,
       ROUND(SUM(sales), 2)  AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;
-- Output: Phones 330007.05 / 44515.73 | Chairs 328449.10 / 26590.17 | Tables 206965.53 / -17725.48 (loss) | Bookcases / -3472.56 (loss)

-- 4.4 Total Sales and Orders by Segment
SELECT segment,
       ROUND(SUM(sales), 2)     AS total_sales,
       COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;
-- Output: Consumer 1161401.35 / 2586 orders | Corporate 706146.37 / 1514 | Home Office 429653.15 / 909


-- ============================================================
-- STEP 5: SORT AND LIMIT RESULTS (Top Products, Top Categories)
-- ============================================================

-- 5.1 Top 10 Products by Total Sales
SELECT product_name,
       ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
-- Output: Canon imageCLASS 2200 Copier leads at 61599.82 | Fellowes PB500 27453.38 | Cisco TelePresence 22638.48

-- 5.2 Top 5 Most Profitable Products
SELECT product_name,
       ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 5;
-- Output: Canon imageCLASS 2200 Copier 25199.93 | Fellowes PB500 7753.04 | HP LaserJet 3310 6983.88

-- 5.3 Top 5 Loss-Making Products
SELECT product_name,
       ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 5;
-- Output: Cubify CubeX 3D Printer Double Head -8879.97 | Lexmark MX611dhe -4589.97 | Cubify Triple Head -3839.99

-- 5.4 Top 5 Sub-Categories by Average Sale Value
SELECT category,
       sub_category,
       ROUND(AVG(sales), 2) AS avg_sales
FROM superstore
GROUP BY category, sub_category
ORDER BY avg_sales DESC
LIMIT 5;
-- Output: Technology/Copiers 2198.94 | Technology/Machines 1645.55 | Furniture/Tables 648.79 | Furniture/Chairs 532.33


-- ============================================================
-- STEP 6: SOLVE USE CASES (Monthly Trends, Top Customers, Duplicates)
-- ============================================================

-- 6.1 Monthly Sales Trend (2014–2017)
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       ROUND(SUM(sales), 2)             AS monthly_sales,
       COUNT(DISTINCT order_id)         AS orders
FROM superstore
GROUP BY month
ORDER BY month;
-- Output: 48 months shown | Jan lowest (14236.90 in 2014) | Nov 2017 highest at 118447.83 with 261 orders | Sep/Nov/Dec peak every year

-- 6.2 Top 10 Customers by Total Sales
SELECT customer_name,
       segment,
       region,
       ROUND(SUM(sales), 2)     AS total_sales,
       COUNT(DISTINCT order_id) AS total_orders
FROM superstore
GROUP BY customer_name, segment, region
ORDER BY total_sales DESC
LIMIT 10;
-- Output: Sean Miller (Home Office, South) 23669.20 / 2 orders | Tamara Chand (Corporate, Central) 18437.14 | Raymond Buch 14345.28

-- 6.3 Multi-Item Orders (Duplicate Order ID Check)
SELECT order_id,
       COUNT(*) AS item_count
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY item_count DESC
LIMIT 5;
-- Output: CA-2017-100111: 14 items | CA-2017-157987: 12 | US-2016-108504: 11 | CA-2016-165330: 11 | CA-2015-131338: 10

-- 6.4 Loss-Making Orders (Negative Profit)
SELECT order_id,
       customer_name,
       category,
       ROUND(sales, 2)    AS sales,
       ROUND(profit, 2)   AS profit,
       ROUND(discount, 2) AS discount
FROM superstore
WHERE profit < 0
ORDER BY profit ASC
LIMIT 8;
-- Output: CA-2016-108196 Cindy Stewart Technology 4499.99 / -6599.98 / 0.70 | US-2017-168116 Grant Thornton 7999.98 / -3839.99 / 0.50

-- 6.5 Region-wise Category Sales Breakdown
SELECT region,
       category,
       ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY region, category
ORDER BY region, total_sales DESC;
-- Output: Central: Technology 170416.31 | East: Technology 264973.98 | South: Technology 148771.91 | West: Furniture 252612.74 leads


-- ============================================================
-- STEP 7: VALIDATE RESULTS (Row Counts, Data Quality)
-- ============================================================

-- 7.1 Row Count Confirmation
SELECT COUNT(*) AS total_rows FROM superstore;
-- Output: total_rows = 9994 — matches original CSV exactly.

-- 7.2 NULL Check on All Key Columns
SELECT
    SUM(CASE WHEN order_id      IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS null_customer,
    SUM(CASE WHEN sales         IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN profit        IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN region        IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN category      IS NULL THEN 1 ELSE 0 END) AS null_category
FROM superstore;
-- Output: null_order_id=0 | null_customer=0 | null_sales=0 | null_profit=0 | null_region=0 | null_category=0

-- 7.3 Sales Range and Total Revenue Validation
SELECT ROUND(MIN(sales), 2)  AS min_sales,
       ROUND(MAX(sales), 2)  AS max_sales,
       ROUND(AVG(sales), 2)  AS avg_sales,
       ROUND(SUM(sales), 2)  AS total_sales
FROM superstore;
-- Output: min_sales=0.44 | max_sales=22638.48 | avg_sales=229.86 | total_sales=2297200.86

-- 7.4 Distinct Counts — Uniqueness Validation
SELECT
    COUNT(DISTINCT order_id)    AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT product_id)  AS unique_products,
    COUNT(DISTINCT region)      AS unique_regions,
    COUNT(DISTINCT state)       AS unique_states
FROM superstore;
-- Output: unique_orders=5009 | unique_customers=793 | unique_products=1862 | unique_regions=4 | unique_states=49