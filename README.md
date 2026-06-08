# Celebal Excellence Internship

This repository contains all assignments, projects, and learning outcomes completed during my **Celebal Excellence Internship** in the **Data Engineering Domain**. Each week's work is organized into separate folders and includes datasets, source code, SQL scripts, reports, and supporting documentation.

---

## Repository Structure

```text
CEI_Internship
├── Week 1 Assignment
│   ├── assignment.ipynb
│   ├── cleaned_dataset.csv
│   └── Combined_dataset.csv
│
├── Week 2 Assignment
│   ├── Assignment 2 (Query + Brief Insights).pdf
│   ├── Assignment_2.sql
│   ├── Assignment-2_Superstore_SQL_Analysis.pdf
│   ├── Sample - Superstore.csv
│   └── Superstore_SQL_Analysis.sql
│
├── Week 3 Assignment
│   ├── Week_3_Assignment.pdf
│   ├── Week_3_Assignment_SQL_Queries.sql
│   └──Sample - Superstore.csv
│
└── README.md
```

---

# Week 1 — Python Basics & Data Exploration

**Objective:** Learn Python fundamentals and perform data exploration, cleaning, and preprocessing using Pandas.

**Dataset:** Shopping Dataset (Kaggle)
**File Used:** `Combined_dataset.csv`

### What I Did

1. Loaded the dataset into a Pandas DataFrame.
2. Explored the dataset using:

   * `head()`
   * `tail()`
   * `shape`
   * `columns`
   * `dtypes`
   * `info()`
   * `describe()`
3. Identified missing values using `isnull().sum()`.
4. Removed irrelevant columns and handled missing values.
5. Filtered records based on product ratings and selected attributes.
6. Removed duplicate entries using `drop_duplicates()`.
7. Created a derived column:

   * `total_amount = initial_price × quantity`
8. Exported the cleaned dataset for further analysis.

### Output

| File                  | Description                                                            |
| --------------------- | ---------------------------------------------------------------------- |
| `assignment.ipynb`    | Complete Python notebook containing data exploration and preprocessing |
| `cleaned_dataset.csv` | Final cleaned dataset after preprocessing                              |

### Skills Applied

* Python
* Pandas
* Data Cleaning
* Data Exploration
* Feature Engineering
* Data Validation

---

# Week 2 — SQL Data Analysis using Superstore Dataset

**Objective:** Perform sales analysis using SQL by applying filtering, aggregation, grouping, sorting, and business-oriented analytical queries.

**Dataset:** Superstore Sales Dataset (2014–2017)

**RDBMS Used:** MySQL

### Dataset Overview

The Superstore dataset contains retail sales transactions from a US-based superstore covering:

* Furniture
* Office Supplies
* Technology

The dataset includes:

* Customer Information
* Product Information
* Order Details
* Shipping Details
* Sales Metrics
* Profit Metrics
* Regional Information

The dataset spans four regions of the United States:

* East
* West
* Central
* South

### What I Did

#### Database Setup

1. Created a MySQL database named `superstore_db`.
2. Designed and created the `superstore` table with 21 attributes.
3. Imported the Superstore dataset into MySQL.
4. Verified successful loading using row counts and sample queries.

#### Data Exploration

1. Examined table schema using:

   * `DESCRIBE`
   * `SHOW COLUMNS`
2. Retrieved sample records using:

   * `SELECT`
   * `LIMIT`

#### Filtering & Retrieval

Applied SQL filters using:

* Region
* Category
* Sales Amount
* Order Date
* Profit
* Discount

#### Aggregation & Grouping

Used aggregate functions:

* `SUM()`
* `AVG()`
* `COUNT()`
* `MIN()`
* `MAX()`

#### Sorting & Ranking

Applied:

* `ORDER BY`
* `LIMIT`

to identify:

* Top Selling Products
* Most Profitable Products
* Top Customers
* Highest Revenue Categories

#### Business Analysis Queries

Performed analysis on:

1. Monthly Sales Trends
2. Customer Purchase Behavior
3. Category Performance
4. Regional Sales Distribution
5. Product Profitability
6. Multi-item Orders
7. Duplicate Order Investigation
8. Customer Segmentation Analysis

#### Data Quality Validation

Validated data through:

* Row Count Checks
* Duplicate Detection
* Null Value Verification
* Order Consistency Checks

### Output

| File                                        | Description                                               |
| ------------------------------------------- | --------------------------------------------------------- |
| `Assignment 2 (Query + Brief Insights).pdf` | SQL queries, outputs, observations, and business insights |
| `Assignment_2.sql`                          | Assignment queries and solutions                          |
| `Assignment-2_Superstore_SQL_Analysis.pdf`  | Complete SQL analysis report                              |
| `Superstore_SQL_Analysis.sql`               | Full SQL script containing all analysis queries           |

### Key Insights

* Technology products generated significant revenue contribution.
* Customer purchasing patterns showed concentration among top buyers.
* Monthly sales trends highlighted seasonal fluctuations.
* Certain products generated high sales but comparatively lower profits due to discounts.
* Multi-item orders represented a considerable share of overall transactions.
* Regional performance varied significantly across different categories.

### SQL Concepts Practiced

* SELECT
* WHERE
* ORDER BY
* LIMIT
* GROUP BY
* HAVING
* Aggregate Functions
* Date Functions
* Data Validation Queries
* Business Analytics Queries

---

# Week 3 — Advanced SQL Analysis using Subqueries, CTEs & Window Functions

**Objective:** Use advanced SQL techniques such as Subqueries, Common Table Expressions (CTEs), and Window Functions to perform customer-centric sales analysis on the Superstore dataset.

**Dataset:** Superstore Sales Dataset (2014–2017)

**RDBMS Used:** MySQL

### What I Did

#### Database Design & Data Preparation

1. Created a staging table `superstore_raw`.
2. Imported the Superstore CSV dataset using `LOAD DATA INFILE`.
3. Performed data transformation using `STR_TO_DATE()`.
4. Normalized the dataset into:

   * `customers`
   * `products`
   * `orders`
5. Removed duplicate records using `SELECT DISTINCT`.

#### Subquery Analysis

Implemented business queries using subqueries:

1. Orders with Sales Above Average Sales.
2. Highest Sales Order for Each Customer.

#### Common Table Expressions (CTEs)

Created reusable query blocks to:

1. Calculate Total Sales per Customer.
2. Identify Customers with Above-Average Sales.
3. Simplify complex analytical queries.

#### Window Function Analysis

Applied advanced analytical functions:

1. `RANK()`

   * Rank customers based on total sales.
   * Identify Top 3 Customers.

2. `ROW_NUMBER()`

   * Generate sequential order numbers for each customer.
   * Analyze customer ordering behavior using `PARTITION BY`.

#### Combined Analytics Query

Created a comprehensive query combining:

* JOIN Operations
* CTEs
* Window Functions
* Aggregations
* Ranking

to generate customer-level performance reports.

#### Mini Project — Customer Sales Insights

Performed customer-focused business analysis:

1. Top 5 Customers by Revenue.
2. Bottom 5 Customers by Revenue.
3. Customers with Only One Order.
4. Customers with Above-Average Sales.
5. Highest Order Value per Customer.

### Output

| File                                | Description                                                             |
| ----------------------------------- | ----------------------------------------------------------------------- |
| `Week_3_Assignment.pdf`             | Complete assignment report with queries, outputs, and business insights |
| `Week_3_Assignment_SQL_Queries.sql` | SQL script containing all Subquery, CTE, and Window Function queries    |
| `Sample - Superstore.csv`           | Dataset used for analysis                                               |

### Key Insights

* Top customers generated between **$14K and $25K** in total sales, highlighting revenue concentration among a small customer group.
* Bottom customers contributed less than **$25** in total sales, indicating low engagement.
* Only **12 out of 793 customers** placed a single order, representing potential churn risk.
* Customers with above-average sales contribute a significant share of overall revenue.
* High-value orders from customers such as Sean Miller and Tamara Chand heavily influence total sales.
* Repeat purchases contribute more to long-term revenue than isolated large transactions.
* Customer ranking helps prioritize retention and relationship-management efforts.
* Window Functions provide powerful tools for customer lifecycle analysis and sales performance tracking.

### SQL Concepts Practiced

* Subqueries
* Correlated Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* RANK()
* ROW_NUMBER()
* PARTITION BY
* Aggregate Functions
* Customer Analytics
* Sales Ranking
* Business Intelligence Queries

---

# Tools & Technologies

### Programming & Analysis

* Python 3
* Pandas
* NumPy
* Jupyter Notebook

### Database & Querying

* MySQL
* MySQL Workbench

### Documentation

* Markdown
* PDF Reports

---

## Learning Outcomes

Through this internship, I gained hands-on experience in:

* Data Cleaning and Preprocessing
* Exploratory Data Analysis (EDA)
* SQL Query Development
* Relational Database Management
* Advanced SQL Techniques
* Subqueries and CTEs
* Window Function Analytics
* Customer Segmentation Analysis
* Business-Oriented Data Analysis
* Reporting and Documentation

---

*This repository will be updated weekly as new assignments and projects are completed throughout the Celebal Excellence Internship.*
