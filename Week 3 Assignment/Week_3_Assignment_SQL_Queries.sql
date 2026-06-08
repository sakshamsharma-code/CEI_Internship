-- ============================================================
-- Celebal Excellence Internship 2026 
-- Week 3 Assignment
-- Submitted By: Saksham Sharma
-- Dataset: Sample - Superstore
-- Database: MySQL
-- ============================================================

CREATE DATABASE IF NOT EXISTS superstore_w3;
USE superstore_w3;

-- ============================================================
-- STEP 1: SETUP DATA
-- ============================================================

CREATE TABLE superstore_raw (
 row_id INT,
 order_id VARCHAR(20),
 order_date DATE,
 ship_date DATE,
 ship_mode VARCHAR(30),
 customer_id VARCHAR(20),
 customer_name VARCHAR(50),
 segment VARCHAR(20),
 country VARCHAR(30),
 city VARCHAR(50),
 state VARCHAR(30),
 postal_code INT,
 region VARCHAR(20),
 product_id VARCHAR(20),
 category VARCHAR(30),
 sub_category VARCHAR(30),
 product_name VARCHAR(200),
 sales DECIMAL(10,4),
 quantity INT,
 discount DECIMAL(5,2),
 profit DECIMAL(10,4)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE superstore_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
 row_id, order_id, @order_date, @ship_date, ship_mode,
 customer_id, customer_name, segment, country, city, state,
 postal_code, region, product_id, category, sub_category,
 product_name, sales, quantity, discount, profit
)
SET
 order_date = STR_TO_DATE(@order_date, '%m/%d/%Y'),
 ship_date = STR_TO_DATE(@ship_date, '%m/%d/%Y');


-- ============================================================
-- Create normalized tables for customers, products, and orders
-- ============================================================


CREATE TABLE customers (
 customer_id VARCHAR(20),
 customer_name VARCHAR(50),
 segment VARCHAR(20)
);

INSERT INTO customers
SELECT DISTINCT customer_id, customer_name, segment
FROM superstore_raw;

CREATE TABLE products (
 product_id VARCHAR(20),
 product_name VARCHAR(200),
 category VARCHAR(50),
 sub_category VARCHAR(50)
);

INSERT INTO products
SELECT DISTINCT product_id, product_name, category, sub_category
FROM superstore_raw;

CREATE TABLE orders (
 order_id VARCHAR(20),
 customer_id VARCHAR(20),
 product_id VARCHAR(20),
 order_date DATE,
 ship_date DATE,
 ship_mode VARCHAR(30),
 sales DECIMAL(10,4),
 quantity INT,
 discount DECIMAL(5,2),
 profit DECIMAL(10,4)
);

INSERT INTO orders
SELECT DISTINCT order_id, customer_id, product_id,
 order_date, ship_date, ship_mode,
 ROUND(sales, 4),
 quantity,
 ROUND(discount, 2),
 ROUND(profit, 4)
FROM superstore_raw;

-- ============================================================
-- STEP 2: REQUIRED QUERIES
-- ============================================================

-- Subquery 1 — Orders Where Sales > Average Sales
SELECT o.order_id, c.customer_name, p.product_name,
 ROUND(o.sales,2) AS sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE o.sales > (SELECT AVG(sales) FROM orders)
ORDER BY o.sales DESC
LIMIT 10;

-- Subquery 2 — Highest Sales Order per Customer
SELECT c.customer_name, o.order_id,
 ROUND(o.sales,2) AS highest_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.sales = (
 SELECT MAX(o2.sales)
 FROM orders o2
 WHERE o2.customer_id = o.customer_id
)
ORDER BY highest_sales DESC
LIMIT 10;

-- CTE 1 — Total Sales per Customer
WITH customer_sales AS (
 SELECT c.customer_id, c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_sales
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;

-- CTE 2 — Customers Whose Total Sales Are Above Average
WITH customer_sales AS (
 SELECT c.customer_id, c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, total_sales
FROM customer_sales
WHERE total_sales > (SELECT AVG(total_sales) FROM customer_sales)
ORDER BY total_sales DESC;

-- Window Function 1 — Rank All Customers by Total Sales
WITH customer_sales AS (
 SELECT c.customer_id, c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_sales,
 RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales
LIMIT 10;

-- Window Function 2 — Row Number per Order Within Each Customer
SELECT c.customer_name, o.order_id, o.order_date,
 ROUND(o.sales,2) AS sales,
 ROW_NUMBER() OVER (
 PARTITION BY o.customer_id
 ORDER BY o.order_date
 ) AS order_seq
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY c.customer_name, order_seq
LIMIT 12;

-- Window Function 3 — Top 3 Customers by Total Sales
WITH customer_sales AS (
 SELECT c.customer_id, c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
),
ranked AS (
 SELECT customer_name, total_sales,
 RANK() OVER (ORDER BY total_sales DESC) AS rnk
 FROM customer_sales
)
SELECT customer_name, total_sales, rnk
FROM ranked
WHERE rnk <= 3;

-- ============================================================
-- STEP 3: FINAL COMBINED QUERY
-- ============================================================

WITH customer_sales AS (
 SELECT c.customer_id, c.customer_name, c.segment,
 ROUND(SUM(o.sales),2) AS total_sales,
 COUNT(DISTINCT o.order_id) AS total_orders
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name, c.segment
)
SELECT customer_name, segment, total_sales, total_orders,
 RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM customer_sales
ORDER BY sales_rank
LIMIT 15;

-- ============================================================
-- MINI PROJECT: CUSTOMER SALES INSIGHTS
-- ============================================================

-- Q1. Top 5 Customers
WITH customer_sales AS (
 SELECT c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_sales,
 RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM customer_sales
ORDER BY rnk
LIMIT 5;

-- Q2. Bottom 5 Customers
WITH customer_sales AS (
 SELECT c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_sales,
 RANK() OVER (ORDER BY total_sales ASC) AS rnk
FROM customer_sales
ORDER BY rnk
LIMIT 5;

-- Q3. Customers With Only One Order
SELECT c.customer_name,
 COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) = 1
ORDER BY c.customer_name;

-- Q4. Customers With Above-Average Sales
WITH customer_sales AS (
 SELECT c.customer_name,
 ROUND(SUM(o.sales),2) AS total_sales
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_sales
FROM customer_sales
WHERE total_sales > (SELECT AVG(total_sales) FROM customer_sales)
ORDER BY total_sales DESC;

-- Q5. Highest Order Value per Customer
WITH ranked_orders AS (
 SELECT c.customer_name, o.order_id,
 ROUND(SUM(o.sales),2) AS order_sales,
 RANK() OVER (
 PARTITION BY o.customer_id
 ORDER BY SUM(o.sales) DESC
 ) AS rnk
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 GROUP BY c.customer_name, o.customer_id, o.order_id
)
SELECT customer_name, order_id, order_sales
FROM ranked_orders
WHERE rnk = 1
ORDER BY order_sales DESC
LIMIT 10;