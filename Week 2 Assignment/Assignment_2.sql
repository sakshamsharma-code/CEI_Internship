-- ============================================================
--  Celebal Excellence Internship 2026 — Week 2 SQL Assignment
--  ShopEase E-Commerce Sales Database
--  Submitted By: Saksham Sharma
--  Database: MySQL
-- ============================================================


-- ============================================================
-- STEP 1: CREATE DATABASE & USE IT
-- ============================================================

CREATE DATABASE IF NOT EXISTS shopease_db;
USE shopease_db;


-- ============================================================
-- STEP 2: CREATE TABLES
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name  VARCHAR(50)  NOT NULL,
    last_name   VARCHAR(50)  NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    city        VARCHAR(50)  NOT NULL,
    state       VARCHAR(50)  NOT NULL,
    join_date   DATE         NOT NULL,
    is_premium  BOOLEAN      DEFAULT FALSE
);

CREATE INDEX idx_customers_city  ON customers(city);
CREATE INDEX idx_customers_state ON customers(state);

CREATE TABLE products (
    product_id   INT           PRIMARY KEY,
    product_name VARCHAR(100)  NOT NULL,
    category     VARCHAR(50)   NOT NULL,
    brand        VARCHAR(50)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    stock_qty    INT           NOT NULL DEFAULT 0 CHECK (stock_qty >= 0)
);

CREATE INDEX idx_products_category ON products(category);

CREATE TABLE orders (
    order_id     INT           PRIMARY KEY,
    customer_id  INT           NOT NULL,
    order_date   DATE          NOT NULL,
    status       VARCHAR(20)   NOT NULL DEFAULT 'Pending'
                     CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')),
    total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE INDEX idx_orders_date   ON orders(order_date);
CREATE INDEX idx_orders_status ON orders(status);

CREATE TABLE order_items (
    item_id      INT           PRIMARY KEY,
    order_id     INT           NOT NULL,
    product_id   INT           NOT NULL,
    quantity     INT           NOT NULL CHECK (quantity > 0),
    unit_price   DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    discount_pct DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100),
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================================
-- STEP 3: INSERT SAMPLE DATA
-- ============================================================

-- ---------- customers ----------
INSERT INTO customers VALUES
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE),
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE),
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE),
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE),
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE),
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE),
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE),
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE);

-- ---------- products ----------
INSERT INTO products VALUES
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250),
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',          799.00, 500),
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150),
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120),
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200),
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300),
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',   899.00, 180),
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',     599.00, 400);

-- ---------- orders ----------
INSERT INTO orders VALUES
(1001, 101, '2024-08-01', 'Delivered', 4498.00),
(1002, 102, '2024-08-03', 'Delivered',  799.00),
(1003, 103, '2024-08-05', 'Shipped',   7498.00),
(1004, 101, '2024-08-10', 'Delivered', 3499.00),
(1005, 104, '2024-08-12', 'Cancelled', 2999.00),
(1006, 105, '2024-08-15', 'Delivered', 5898.00),
(1007, 106, '2024-08-18', 'Pending',   1299.00),
(1008, 103, '2024-08-20', 'Delivered',  899.00),
(1009, 107, '2024-08-25', 'Shipped',   6098.00),
(1010, 108, '2024-08-28', 'Delivered', 1598.00);

-- ---------- order_items ----------
INSERT INTO order_items VALUES
(5001, 1001, 201, 2, 1499.00,  0),
(5002, 1001, 207, 1,  899.00, 10),
(5003, 1002, 202, 1,  799.00,  0),
(5004, 1003, 203, 1, 2999.00,  0),
(5005, 1003, 204, 1, 4599.00,  5),
(5006, 1004, 205, 1, 3499.00,  0),
(5007, 1005, 203, 1, 2999.00,  0),
(5008, 1006, 201, 1, 1499.00, 10),
(5009, 1006, 204, 1, 4599.00,  5),
(5010, 1007, 206, 1, 1299.00,  0),
(5011, 1008, 207, 1,  899.00,  0),
(5012, 1009, 205, 1, 3499.00,  0),
(5013, 1009, 208, 2,  599.00, 15),
(5014, 1010, 206, 1, 1299.00,  0),
(5015, 1010, 208, 1,  599.00,  0);


-- ============================================================
-- SECTION A — SQL Basics (SELECT, Constraints, Primary Keys)
-- ============================================================

-- Q1. Write a query to display all columns and rows from the customer's table.
-- Output: Returns all 8 rows with every column from the customers table.
SELECT * FROM customers;


-- Q2. Retrieve only the first_name, last_name, and city of all customers.
-- Output: Returns name and city of all 8 customers.
SELECT first_name, last_name, city FROM customers;


-- Q3. List all unique categories available in the products table.
-- Output: Returns 3 distinct categories — Clothing, Electronics, Home.
SELECT DISTINCT category FROM products;


-- Q6. Try inserting a product with unit_price = -50. What happens and which constraint prevents it?
-- Output: Fails with Error Code 3819 — CHECK constraint 'products_chk_1' is violated.
INSERT INTO products VALUES (209, 'Test Product', 'Electronics', 'Brand', -50, 10);


-- ============================================================
-- SECTION B — Filtering & Optimization (WHERE, Indexes)
-- ============================================================

-- Q7. Retrieve all orders with status = 'Delivered'.
-- Output: Returns 6 orders that have been successfully delivered.
SELECT * FROM orders
WHERE status = 'Delivered';


-- Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000.
-- Output: Returns 2 products — Smart Watch (₹2999) and Bluetooth Speaker (₹3499).
SELECT * FROM products
WHERE category = 'Electronics'
  AND unit_price > 2000;


-- Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'.
-- Output: Returns 2 customers — Aarav Sharma (Mumbai) and Karan Mehta (Pune).
SELECT * FROM customers
WHERE join_date >= '2024-01-01'
  AND join_date <  '2025-01-01'
  AND state = 'Maharashtra';


-- Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled.
-- Output: Returns 5 orders within the date range excluding the cancelled one.
SELECT * FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
  AND status <> 'Cancelled';


-- Q11. Write a sample query that would benefit from the index idx_orders_date.
-- Output: Returns 1 order placed on 2024-08-15, fetched efficiently using the date index.
SELECT * FROM orders
WHERE order_date = '2024-08-15';


-- Q12. Rewrite the query SELECT * FROM customers WHERE YEAR(join_date) = 2024 to be index-friendly (SARGable).
-- Output: Returns all 8 customers who joined in 2024 using a range scan on the index.
SELECT * FROM customers
WHERE join_date >= '2024-01-01'
  AND join_date <  '2025-01-01';


-- ============================================================
-- SECTION C — Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX)
-- ============================================================

-- Q13. Count the total number of orders in the orders table.
-- Output: Returns 10 — the total number of orders placed.
SELECT COUNT(*) AS total_orders FROM orders;


-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders.
-- Output: Returns ₹17,191 as total revenue from all delivered orders.
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Delivered';


-- Q15. Calculate the average unit_price of products in each category.
-- Output: Returns avg price per category — Clothing ₹2699, Electronics ₹2224, Home ₹949.
SELECT category,
       ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM products
GROUP BY category;


-- Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in descending order.
-- Output: Returns 4 status groups sorted by revenue — Delivered leads with ₹17,191.
SELECT status,
       COUNT(*)          AS order_count,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY status
ORDER BY total_revenue DESC;


-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category.
-- Output: Returns max and min price for each of the 3 categories.
SELECT category,
       MAX(unit_price) AS most_expensive,
       MIN(unit_price) AS cheapest
FROM products
GROUP BY category;


-- Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING clause)
-- Output: Returns 2 categories — Clothing and Electronics — both with avg price above ₹2000.
SELECT category,
       ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM products
GROUP BY category
HAVING AVG(unit_price) > 2000;


-- ============================================================
-- SECTION D — Joins & Relationships
-- ============================================================

-- Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name.
--      Show: order_id, order_date, first_name, last_name, total_amount.
-- Output: Returns 10 rows — each order matched with its customer's name.
SELECT o.order_id,
       o.order_date,
       c.first_name,
       c.last_name,
       o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;


-- Q20. Using a LEFT JOIN, list ALL customers and their orders (if any).
--      Customers with no orders should still appear with NULL values for order columns.
-- Output: Returns all 8 customers; those without orders would show NULL in order columns.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       o.order_id,
       o.order_date,
       o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


-- Q21. Write a query using JOINs across three tables (orders → order_items → products) to show:
--      order_id, product_name, quantity, unit_price, and discount_pct for each order item.
-- Output: Returns 15 rows — every item across all orders with its product details.
SELECT oi.order_id,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       oi.discount_pct
FROM order_items oi
JOIN orders   o ON oi.order_id   = o.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id;


-- Q22. LEFT JOIN example from schema.
-- Output: Returns all customers with their order IDs; unmatched customers would show NULL.
SELECT c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Q22. RIGHT JOIN example from schema.
-- Output: Returns all orders with customer names; unmatched orders would show NULL.
SELECT c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;


-- Q23. Identify all Foreign Key relationships in the schema. Explain what would happen
--      if you tried to insert an order with customer_id = 999 (which doesn't exist in customers).
-- Output: Fails with Error Code 1452 — foreign key constraint fails, INSERT is rejected.
INSERT INTO orders VALUES (1012, 999, '2024-08-31', 'Pending', 500.00);


-- ============================================================
-- SECTION E — Advanced Concepts (CASE, ACID, Transactions)
-- ============================================================

-- Q24. Write a query using CASE to classify products into price tiers:
--      'Budget' → unit_price < 1000
--      'Mid-Range' → unit_price BETWEEN 1000 AND 3000
--      'Premium' → unit_price > 3000
--      Display: product_name, unit_price, price_tier.
-- Output: Returns all 8 products each labeled as Budget, Mid-Range, or Premium.
SELECT product_name,
       unit_price,
       CASE
           WHEN unit_price < 1000                THEN 'Budget'
           WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
           ELSE                                       'Premium'
       END AS price_tier
FROM products;


-- Q25. Using a CASE statement inside an aggregate function, count how many orders are
--      'Delivered' vs 'Not Delivered' (all other statuses). Display the result in a single row.
-- Output: Returns a single row — 6 delivered and 4 not delivered orders.
SELECT
    SUM(CASE WHEN status = 'Delivered'  THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN status <> 'Delivered' THEN 1 ELSE 0 END) AS not_delivered_orders
FROM orders;


-- Q27. Write a SQL transaction that does the following atomically:
--      1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00)
--      2. Insert two order items for that order
--      3. Update the stock_qty of the purchased products
--      4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT.
-- Output: All 5 statements succeed and COMMIT makes the changes permanent.
BEGIN;

    -- Step 1: Insert new order
    INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
    VALUES (1011, 102, CURRENT_DATE, 'Pending', 1598.00);

    -- Step 2a: Insert first order item — Bedsheet Set (product 206), qty 1
    INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
    VALUES (5016, 1011, 206, 1, 1299.00, 0);

    -- Step 2b: Insert second order item — Cushion Covers (product 208), qty 1
    INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
    VALUES (5017, 1011, 208, 1, 599.00, 0);

    -- Step 3a: Reduce stock for Bedsheet Set
    UPDATE products
    SET stock_qty = stock_qty - 1
    WHERE product_id = 206;

    -- Step 3b: Reduce stock for Cushion Covers
    UPDATE products
    SET stock_qty = stock_qty - 1
    WHERE product_id = 208;

COMMIT;
-- If any step above fails, run ROLLBACK instead:
-- ROLLBACK;


-- ============================================================
-- VALIDATION QUERIES
-- ============================================================

-- Row count check across all tables
-- Output: Confirms 8 customers, 8 products, 10 orders, 15 order items loaded correctly.
SELECT 'customers'    AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'products',    COUNT(*) FROM products
UNION ALL
SELECT 'orders',      COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items;

-- Verify transaction result
-- Output: Confirms order 1011 exists with 2 items and stock reduced by 1 for each product.
SELECT * FROM orders      WHERE order_id = 1011;
SELECT * FROM order_items WHERE order_id = 1011;
SELECT product_id, product_name, stock_qty
FROM products WHERE product_id IN (206, 208);

-- ============================================================
-- END OF SCRIPT
-- ============================================================