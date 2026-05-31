# Celebal Excellence Internship
This repository contains all assignments and work submitted during my Celebal Excellence Internship for the Data Engineering domain. Each week covers different concepts and is organized in its own folder.
 
---
 
## Repository Structure
 
```
├── Week-1/
│   ├── assignment.ipynb
│   ├── cleaned_dataset.csv
│   └── Combined_dataset.csv
├── Week-2/
│   ├── Assignment_2_Query_Brief_Insights.pdf
│   └── ShopEase_Week2_Complete.sql
└── README.md
```
 
---
 
## Week 1 — Python Basics & Data Exploration
 
**Objective:** Learn Python basics and perform data exploration and cleaning using Pandas.
 
**Dataset:** [Shopping Dataset — Kaggle](https://www.kaggle.com/datasets/anvitkumar/shopping-dataset)  
**File used:** `Combined_dataset.csv` (1000 rows × 24 columns)
 
### What I did
1. Loaded the CSV dataset into a Pandas DataFrame
2. Explored the data using `head()`, `tail()`, `shape`, `columns`, `dtypes`, `info()` and `describe()`
3. Identified missing values using `isnull().sum()` and handled them — dropped useless columns (`videos`, `seller_information`), filled remaining nulls using `fillna()`
4. Filtered rows with rating greater than 4 and selected specific columns for analysis
5. Removed duplicate rows using `drop_duplicates()`
6. Created a derived column `total_amount = initial_price × quantity`
7. Saved the final cleaned dataset as `cleaned_dataset.csv`
### Output
| File | Description |
|---|---|
| `assignment.ipynb` | Jupyter notebook with all steps |
| `cleaned_dataset.csv` | Final cleaned dataset with 0 null values |
 
---
 
## Week 2 — SQL Data Analysis & E-Commerce Sales Database
 
**Objective:** Analyze sales data using SQL with filtering, aggregation, and business queries on a relational e-commerce database.
 
**Database:** ShopEase — a mid-sized e-commerce company selling Electronics, Clothing, and Home products across India  
**RDBMS used:** MySQL
 
### What I did
1. Designed and created a relational database with 4 tables — `customers`, `products`, `orders`, `order_items` — with proper Primary Keys, Foreign Keys, CHECK constraints, UNIQUE constraints, and indexes
2. Loaded sample data (8 customers, 8 products, 10 orders, 15 order items) using INSERT statements
3. Applied WHERE filters to retrieve delivered orders, electronics above ₹2000, Maharashtra customers, and date-range filtered orders
4. Explained index behavior and rewrote a non-SARGable query (`YEAR(join_date)`) into an index-friendly range query
5. Used GROUP BY with COUNT, SUM, AVG, MIN, MAX to find revenue by status, average prices by category, and price extremes
6. Applied HAVING clause to filter categories where average price exceeds ₹2000
7. Wrote INNER JOIN, LEFT JOIN, and 3-table JOIN queries across customers, orders, order_items, and products
8. Used CASE statements for price tier classification and conditional aggregation in a single row
9. Explained ACID properties with real-world examples
10. Wrote a complete `BEGIN...COMMIT/ROLLBACK` transaction that atomically inserts an order, adds two order items, and updates product stock
### Output
| File | Description |
|---|---|
| `Assignment_2_Query_Brief_Insights.pdf` | Full assignment with all queries, results, theory answers, and business insights |
| `ShopEase_Week2_Complete.sql` | Complete SQL script — table creation, data insertion, and all section-wise queries |
 
### Key Insights
- Total revenue from Delivered orders: **₹17,191** (49% of all orders)
- **₹13,596** in Shipped orders represents potential future revenue
- Clothing has the highest average price (**₹2,699**), Home is the most affordable (**₹949**)
- **Aarav Sharma** is the most active customer (2 orders); **Rohan Gupta** placed the highest single order (₹7,498)
- All 4 premium customers placed orders — suggesting premium membership drives engagement
---
 
## Tools & Libraries
 
- Python 3
- Pandas
- NumPy
- Jupyter Notebook
- MySQL
- MySQL Workbench
---
 
*This repository will be updated weekly as new assignments are completed.*
