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
│   └── Sample - Superstore.csv
│
├── Week 4 Assignment
│   ├── Week_4_Assignment.pdf
│   └── Sample_-_Superstore.csv
│
├── Week 5 Assignment
│   ├── data/dataset.csv
│   ├── notebook/spark_basics.ipynb
│   ├── output/results.csv
│   └── README.md
│
├── Week 6 Assignment
│   ├── data/Sample_-_Superstore.csv
│   ├── notebook/Week_6_Assignment.ipynb
│   ├── output/ (filtered_data.csv, output_parquet/)
│   └── README.md
│
├── Week 7 Assignment
│   ├── data/ (customer_master.csv, customer_incremental.csv, customer_master_cleaned.csv, customer_master_scd2.csv)
│   ├── notebook/delta_scd_assignment.ipynb
│   ├── screenshots/
│   ├── report/assignment_summary.pdf
│   └── README.md
│
├── Week 8 Assignment
│   ├── ecommerce-analytics-system/
│   │   ├── data/ (raw + cleaned)
│   │   ├── scripts/ (generate, clean, load, report_cli, test_cases)
│   │   ├── sql/ (schema, aggregations, window_functions, cohort_analysis)
│   │   ├── output/sample_reports/
│   │   └── screenshots/
│   └── README.md
│
├── CEI Intern Project
│   └── Retail E-Commerce Sales Analytics Pipeline
│       ├── 00_setup.ipynb
│       ├── 01_bronze.ipynb
│       ├── 02_silver_stage1.ipynb
│       ├── 03_silver_stage2_scd2.ipynb
│       ├── 04_gold.ipynb
│       ├── datasets/ (batch + incremental)
│       ├── results_screenshots/
│       ├── Final_Project_Report.pdf
│       └── README.md
│
└── README.md
```

---

# Week 1 — Python Basics & Data Exploration

**Objective:** Learn Python fundamentals and perform data exploration, cleaning, and preprocessing using Pandas.

**Dataset:** Shopping Dataset (Kaggle) | **File Used:** `Combined_dataset.csv`

### What I Did

1. Loaded the dataset into a Pandas DataFrame.
2. Explored using `head()`, `tail()`, `shape`, `columns`, `dtypes`, `info()`, `describe()`.
3. Identified missing values using `isnull().sum()`.
4. Removed irrelevant columns and handled missing values.
5. Filtered records based on product ratings and selected attributes.
6. Removed duplicate entries using `drop_duplicates()`.
7. Created a derived column: `total_amount = initial_price × quantity`.
8. Exported the cleaned dataset for further analysis.

### Output

| File | Description |
|---|---|
| `assignment.ipynb` | Complete Python notebook containing data exploration and preprocessing |
| `cleaned_dataset.csv` | Final cleaned dataset after preprocessing |

### Skills Applied

Python · Pandas · Data Cleaning · Data Exploration · Feature Engineering · Data Validation

---

# Week 2 — SQL Data Analysis using Superstore Dataset

**Objective:** Perform sales analysis using SQL by applying filtering, aggregation, grouping, sorting, and business-oriented analytical queries.

**Dataset:** Superstore Sales Dataset (2014–2017) | **RDBMS:** MySQL

### What I Did

**Database Setup:** Created `superstore_db`, designed the `superstore` table (21 attributes), imported and verified the dataset.

**Data Exploration:** Examined schema using `DESCRIBE`/`SHOW COLUMNS`, retrieved sample records.

**Filtering, Aggregation & Business Analysis:** Applied filters on Region, Category, Sales, Order Date, Profit, Discount. Used `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`, `ORDER BY`/`LIMIT` for top products/customers/categories. Analyzed Monthly Sales Trends, Customer Purchase Behavior, Category Performance, Regional Sales Distribution, Product Profitability, Customer Segmentation.

### Output

| File | Description |
|---|---|
| `Assignment 2 (Query + Brief Insights).pdf` | SQL queries, outputs, observations, and business insights |
| `Assignment_2.sql` | Assignment queries and solutions |
| `Assignment-2_Superstore_SQL_Analysis.pdf` | Complete SQL analysis report |
| `Superstore_SQL_Analysis.sql` | Full SQL script containing all analysis queries |

### Key Insights

Technology products generated significant revenue contribution. Monthly sales trends highlighted seasonal fluctuations. Certain products generated high sales but lower profits due to heavy discounts. Regional performance varied significantly across different categories.

### SQL Concepts Practiced

`SELECT` · `WHERE` · `ORDER BY` · `GROUP BY` · `HAVING` · Aggregate Functions · Date Functions · Data Validation · Business Analytics

---

# Week 3 — Advanced SQL: Subqueries, CTEs & Window Functions

**Objective:** Use advanced SQL techniques — Subqueries, CTEs, Window Functions — for customer-centric sales analysis.

**Dataset:** Superstore Sales Dataset (2014–2017) | **RDBMS:** MySQL

### What I Did

**Database Design & Data Preparation:** Created staging table `superstore_raw`, imported via `LOAD DATA INFILE`, transformed dates with `STR_TO_DATE()`, normalized into `customers`, `products`, `orders` tables, deduplicated with `SELECT DISTINCT`.

**Subquery & CTE Analysis:** Orders with above-average sales, highest sales order per customer (correlated subqueries), total sales per customer via CTEs.

**Window Function Analysis:** `RANK()` for top customers by sales, `ROW_NUMBER()` with `PARTITION BY` for per-customer order sequencing.

**Mini Project:** Top 5 / Bottom 5 customers by revenue, customers with only one order, above-average customers, highest order value per customer.

### Output

| File | Description |
|---|---|
| `Week_3_Assignment.pdf` | Complete assignment report with queries, outputs, and business insights |
| `Week_3_Assignment_SQL_Queries.sql` | SQL script containing all Subquery, CTE, and Window Function queries |
| `Sample - Superstore.csv` | Dataset used for analysis |

### Key Insights

Top customers generated between **$14K and $25K** in total sales. Bottom customers contributed less than **$25** — potential churn risk. Only **12 out of 793 customers** placed a single order. High-value orders from customers like Sean Miller and Tamara Chand heavily influence total revenue.

### SQL Concepts Practiced

`Subqueries` · `Correlated Subqueries` · `CTEs` · `RANK()` · `ROW_NUMBER()` · `PARTITION BY` · Aggregate Functions · Customer Analytics · Business Intelligence

---

# Week 4 — Azure Cloud Fundamentals & Data Pipeline using ADF

**Objective:** Understand Azure cloud concepts and build a complete end-to-end data pipeline using Azure Storage Account and Azure Data Factory (ADF).

**Dataset:** Superstore Sales Dataset | **Platform:** Microsoft Azure (Free Student Subscription)

### What I Did

**Azure Environment Setup:** Created Resource Group (`rg-celebal`), Storage Account (`celebalweek4storage`, LRS), two Blob Containers (`superstore-input`, `superstore-output`).

**Azure Data Factory Setup:** Created ADF instance (`adf-celebal-4thweek`), explored Author/Monitor/Manage. Created Linked Service (`ls_blob_superstore`) via Account Key auth. Defined DelimitedText Datasets for source and destination.

**Pipeline Development:** Built `pl_superstore_pipeline` with **Get Metadata** (itemName, size, lastModified, columnCount) chained to **Copy Data** via success dependency, with 21-column schema mapping and fault tolerance for malformed rows.

**Execution & Monitoring:** Ran in Debug mode — both activities completed in under 35 seconds; verified `superstore_processed.csv` created with all **9,994 rows**.

**IAM Role Assignment:**

| Role | Assigned To |
|------|-------------|
| Reader | User account |
| Contributor | User account |
| Storage Blob Data Contributor | ADF Managed Identity |

### Pipeline Architecture

```
Azure Blob Storage (celebalweek4storage)
├── superstore-input/
│   └── Sample_-_Superstore.csv  ──► [Get Metadata] ──► [Copy Data]
│                                          (ADF Pipeline: pl_superstore_pipeline)
└── superstore-output/
    └── superstore_processed.csv  ◄── Copy Data sink
```

### Output

| File | Description |
|---|---|
| `Week_4_Assignment.pdf` | Complete assignment report with screenshots and summary |
| `Sample_-_Superstore.csv` | Source dataset uploaded to Blob Storage |

### Key Learnings

Set up a full Azure cloud environment from scratch. Understood how ADF Linked Services abstract credentials from pipeline logic. Get Metadata + Copy Data chaining enforces a validation-before-copy pattern used in real pipelines. IAM Managed Identity is the recommended secure approach over hardcoded keys. Fault tolerance (`Skip incompatible rows`) is essential for real-world CSVs.

### Azure Services Used

`Azure Portal` · `Resource Groups` · `Storage Account` · `Blob Storage` · `Azure Data Factory` · `Linked Services` · `Datasets` · `Pipelines` · `IAM / RBAC`

---

# Week 5 — Apache Spark Fundamentals & Data Processing

**Objective:** Understand Apache Spark fundamentals and perform data cleaning, transformation, filtering, grouping, and aggregation using PySpark DataFrames.

**Dataset:** CSV Dataset | **Platform:** Apache Spark (PySpark) via Google Colab

### What I Did

Understood MapReduce limitations and Spark's in-memory advantage; Spark architecture (Driver, Executors, Cluster Manager); DataFrames, immutability, lazy evaluation, DAG execution. Set up a Spark Session and loaded a CSV dataset. Explored schema via `show()`, `printSchema()`, `columns`, `dtypes`. Cleaned data using `dropDuplicates()`, `.na.drop()`, `.na.fill()`; renamed columns with `withColumnRenamed()`; cast types with `cast()`. Filtered on Age/Category/Region and aggregated with `count()`, `sum()`, `avg()`, `min()`, `max()`, `groupBy()`. Understood narrow vs wide transformations and shuffle operations. Built a complete Load → Clean → Transform → Filter → Aggregate → Output pipeline.

### Output

| File | Description |
|---|---|
| `spark_basics.ipynb` | Complete PySpark notebook containing all assignment tasks |
| `results.csv` | Processed dataset generated after Spark transformations |
| `README.md` | Assignment documentation and execution guide |

### Spark Concepts Practiced

`Apache Spark` · `PySpark` · `Spark Session` · `DataFrames` · `Lazy Evaluation` · `Immutability` · `Schema Handling` · `Data Cleaning` · `Filtering` · `Aggregation` · `groupBy()` · `Shuffle Operations` · `Wide Transformations` · `Data Processing Pipeline`

---

# Week 6 — Spark Architecture, Performance & File Processing

**Objective:** Understand Apache Spark architecture and perform efficient data processing using transformations, filtering, schema handling, optimized file formats, and Spark performance concepts.

**Dataset:** Superstore Sales Dataset | **Platform:** Apache Spark (PySpark) via Google Colab

### What I Did

Studied Spark Architecture (Driver, Cluster Manager, Executors), Client vs Cluster Mode, Lazy Evaluation, DAG (Lineage Graph), and fault tolerance. Loaded/read CSV and Parquet files. Selected/renamed columns, cast types, added calculated columns via `withColumn()`, applied filters. Compared row-based (CSV) vs columnar (Parquet) storage and Parquet's advantages for analytics. Explored Predicate Pushdown and Spark best practices (`.show()` over `.collect()`). Saved processed data in both CSV and Parquet. Built a complete Load → Schema Inspection → Transformation → Filtering → Column Selection → CSV & Parquet Output pipeline.

### Project Structure

```text
Week 6 Assignment
├── data/Sample_-_Superstore.csv
├── notebook/Week_6_Assignment.ipynb
├── output/
│   ├── filtered_data.csv
│   └── output_parquet/  (part-*.snappy.parquet, _SUCCESS)
└── README.md
```

### Output

| File | Description |
|---|---|
| `Week_6_Assignment.ipynb` | Complete PySpark notebook containing all assignment tasks |
| `filtered_data.csv` | Processed output after Spark transformations and filtering |
| `output_parquet/` | Processed dataset stored in Parquet format |
| `README.md` | Assignment documentation and execution guide |

### Key Learning Outcomes

Spark Architecture · Client vs Cluster Mode · Lazy Evaluation · DAG · Fault Tolerance · DataFrame Transformations · Filtering & Selection · Schema Handling · CSV vs Parquet · Predicate Pushdown · Transformations & Actions · Performance Optimization · End-to-End Spark Pipeline

---

# Week 7 — Delta Lake: Incremental Data Processing & SCD

**Objective:** Perform incremental data processing using Delta Lake — loading datasets into Delta tables, applying MERGE for updates/inserts, validating results, and implementing Slowly Changing Dimensions (SCD).

**Platform:** Databricks (Delta Lake)

### What I Did

**Part 1 — Python & Pandas Basics:** Loaded `customer_master.csv`, explored with `head()`/`tail()`/`shape`/`columns`/`dtypes`, handled missing values (`fillna()`), filtered rows (e.g. Region = West), removed duplicates, created `total_amount = Sales * Quantity`, exported `customer_master_cleaned.csv`.

**Part 2 — Delta Lake MERGE Implementation:**
- Loaded cleaned data into Delta Table `week_7_db.customer_master`.
- Created an incremental dataset: 20 updated records (Sales +10%) + 10 new customer records.
- Applied `DeltaTable.merge()` with `whenMatchedUpdate` + `whenNotMatchedInsertAll` — **SCD Type 1** upsert.
- Validated: row counts before/after MERGE, zero duplicate `Row_ID`s, no nulls in key columns.
- **SCD Type 2:** added `is_current`, `effective_date`, `end_date`; expired old records on match, appended new/incremental rows as current. Exported `customer_master_scd2.csv`.

### Project Structure

```text
Week 7 Assignment
├── data/  (customer_master.csv, customer_incremental.csv, customer_master_cleaned.csv, customer_master_scd2.csv)
├── notebook/delta_scd_assignment.ipynb
├── screenshots/  (data_loading, data_cleaning, scd1, scd2, validation, final_output)
├── report/assignment_summary.pdf
└── README.md
```

### Output

| File | Description |
|---|---|
| `delta_scd_assignment.ipynb` | Complete notebook — Part 1 & Part 2 |
| `customer_master_cleaned.csv` | Cleaned dataset (Part 1 output) |
| `customer_master_scd2.csv` | SCD Type 2 result (Part 2 output) |
| `screenshots/` | Screenshots of each implementation step |
| `assignment_summary.pdf` | Brief report summarizing the assignment |

### Key Learning Outcomes

Python & Pandas cleaning · Delta Lake Fundamentals & ACID Transactions · Incremental Data Processing · MERGE (Upsert) · SCD Type 1 & Type 2 · Data Validation · End-to-End Delta Lake Pipeline

---

# Week 8 — E-Commerce Order Analytics System (Mini Project)

**Objective:** Simulate a real-world scenario where raw e-commerce order data comes in messy from multiple sources, and needs to be cleaned, loaded into a database, and analyzed to generate business reports.

**Stack:** Python, Pandas, SQL (SQLite), CLI tools

### Architecture / Workflow

```
generate_data.py
      |
      v
data/raw/  (messy CSVs - nulls, wrong date formats, bad emails, negative qty)
      |
      v
clean_data.py
      |
      v
data/cleaned/  (cleaned CSVs + issues_report.txt)
      |
      v
load_database.py
      |
      v
ecommerce.db  (SQLite, schema.sql applied)
      |
      v
sql/*.sql  (16 analysis queries - aggregations, window functions, cohort analysis)
      |
      v
report_cli.py  (command line reporting tool)
      |
      v
output/sample_reports/
```

### What I Did

**Data Generation:** 4 CSVs with intentional data quality issues — `customers.csv` (600 rows, ~2% invalid emails), `products.csv` (150 rows, ~15% messy names), `orders.csv` (700 rows, ~5% null customer_id, ~8% wrong date format), `order_items.csv` (1500 rows, ~3% negative quantity, ~3% invalid order_id).

**Data Cleaning:** `clean_orders()` fixes mixed date formats (keeps null customer_id as null), `clean_products()` trims spaces and title-cases names, `validate_emails()` flags invalid customer emails, `check_referential_integrity()` finds orphaned order_items.

**SQL Analysis (16 queries):** Loaded into SQLite (`ecommerce.db`) with PK/FK constraints (`schema.sql`). Covers revenue analysis, customer segmentation (NTILE quartiles), retention/cohort analysis, running totals, ranking (DENSE_RANK), YoY comparisons, products frequently bought together (self-join) — across `aggregations.sql`, `window_functions.sql`, `cohort_analysis.sql`.

**CLI Reporting Tool:** `report_cli.py` — `--report`/`--start`/`--end` args, prints total orders/revenue/customers, top 3 products, % change vs previous equal-length period. Built with only `sqlite3` + `argparse`.

**Edge Case Tests:** `test_cases.py` validates 4 scenarios — order_id not in orders, discount_percent > 100, quantity = 0, future order_date.

### Project Structure

```text
ecommerce-analytics-system/
├── data/
│   ├── raw/            -> generate_data.py output (messy data)
│   └── cleaned/         -> clean_data.py output (cleaned data + issues_report.txt)
├── scripts/
│   ├── generate_data.py, clean_data.py, load_database.py
│   ├── report_cli.py, test_cases.py, run_sql_file.py
├── sql/
│   ├── schema.sql, aggregations.sql, window_functions.sql, cohort_analysis.sql
├── output/sample_reports/
├── screenshots/  (data_generation, data_cleaning, sql_queries, cli, final_output)
├── requirements.txt
└── README.md
```

### Output

| Output | Location |
|---|---|
| Cleaned CSVs | `data/cleaned/` |
| SQLite database | `ecommerce.db` (generated locally) |
| Sample reports | `output/sample_reports/` |
| Screenshots of every step | `screenshots/` |

### Key Learning Outcomes

Python & Pandas data generation/cleaning · SQL schema design (PK/FK) · Window Functions & CTEs · Cohort/Retention analysis · CLI tool development with `argparse` · Referential integrity validation · Edge case testing

---

# Final Project — Retail E-Commerce Sales Analytics Pipeline

**Objective:** Build a complete, production-style end-to-end retail e-commerce data pipeline using Databricks, PySpark, and Delta Lake, applying the Medallion Architecture (Bronze → Silver → Gold), SCD Type 2 history tracking, and Auto Loader-based incremental ingestion — bringing together everything learned across Weeks 1–8.

**Platform:** Databricks (Unity Catalog, Serverless Compute) | **Catalog:** `retail_demo` (schemas: `raw`, `silver`, `gold`)

### Architecture — Medallion Pipeline

```
Raw CSV files (Unity Catalog Volume)
        |
        v
BRONZE   - Raw ingestion, no cleaning, audit columns added
        |          (batch: spark.read | incremental/CDC: Auto Loader)
        v
SILVER 1 - Clean / Cast / Deduplicate / Quarantine bad records
        |
        v
SILVER 2 - SCD Type 2 dimensions (dim_customer_scd2, dim_product_scd2)
        |
        v
GOLD     - Conformed fact_orders (point-in-time join) + 4 analytics tables
```

### What I Did

- **00_setup:** Created Unity Catalog catalog/schemas/volume and reusable path configuration.
- **01_bronze:** Ingested 4 historical batch CSVs (orders, customers, products, stores) as raw strings with audit columns (`source_file`, `ingestion_ts`, `load_type`); ingested 3 days of incremental/CDC files using **Auto Loader** (`cloudFiles`) with schema evolution enabled to handle a new `coupon_code` column appearing on day 3.
- **02_silver_stage1:** Cast raw strings to proper types using `try_cast`/`try_to_date`/`try_to_timestamp` (tolerates malformed values like `"unknown"` prices and invalid dates without crashing the job); split each source into clean + quarantine tables; deduplicated on business key using the latest `ingestion_ts`.
- **03_silver_stage2_scd2:** Built SCD Type 2 dimensions for customers and products — initial load from cleaned batch data, then daily CDC files replayed in `effective_date` order using a two-step MERGE (close old row, insert new row with a fresh surrogate key), with change detection via SHA-256 row hashing.
- **04_gold:** Built `fact_orders` using a **point-in-time date-range join** (order_date between dimension `effective_start_date`/`effective_end_date`) to resolve the correct historical customer/product state as of the order date; built 4 Gold analytics tables — daily sales, category sales, segment sales, region sales; demonstrated Delta Lake table history (`DESCRIBE HISTORY`) and time travel (`versionAsOf`).

### Real-World Issues Handled

- ANSI strict casting failures on malformed dates/numbers → resolved using `try_cast`/`try_to_timestamp`/`try_to_date`
- `input_file_name()` and `rdd.isEmpty()` not supported on serverless Unity Catalog compute → replaced with `_metadata.file_path` and `limit(1).count() == 0`
- SCD2 join ambiguity in Spark Connect → resolved using fully-qualified `F.col("alias.column")` join conditions
- Dimension table row inflation from re-running MERGE cells during debugging → resolved by resetting via the initial-load overwrite before reapplying CDC
- ~7% of fact table rows have a null surrogate key, traced to orders with a date earlier than the referenced customer/product's earliest known record, or referencing a quarantined product — documented as a source data quality finding, not a pipeline defect

### Project Structure

```text
Retail E-Commerce Sales Analytics Pipeline
├── 00_setup.ipynb
├── 01_bronze.ipynb
├── 02_silver_stage1.ipynb
├── 03_silver_stage2_scd2.ipynb
├── 04_gold.ipynb
├── datasets/
│   ├── batch/
│   └── incremental/  (day_2026-04-24, day_2026-04-25, day_2026-04-26)
├── results_screenshots/
│   ├── 00_setup/
│   ├── 01_bronze/
│   ├── 02_silver_stage1/
│   ├── 03_silver_stage2_scd2/
│   ├── 04_gold/
│   └── 05_catalog_overview/
├── Final_Project_Report.pdf
└── README.md
```

### Output — Tables Produced (Catalog: `retail_demo`)

| Schema | Tables |
|---|---|
| raw | bronze_orders, bronze_customers, bronze_products, bronze_stores, bronze_orders_incremental, bronze_customers_cdc, bronze_products_cdc |
| silver | silver1_orders_clean/_quarantine, silver1_customers_clean/_quarantine, silver1_products_clean/_quarantine, dim_store, dim_customer_scd2, dim_product_scd2 |
| gold | fact_orders, gold_daily_sales, gold_category_sales, gold_segment_sales, gold_region_sales |

### Key Learning Outcomes

Medallion Architecture (Bronze/Silver/Gold) · Unity Catalog (Catalog/Schema/Volume) · Auto Loader incremental ingestion · Schema evolution · ANSI-safe type casting (`try_cast`) · Data quarantine pattern · SCD Type 2 (two-step MERGE, surrogate keys, hash-based change detection) · Point-in-time date-range joins · Delta Lake history & time travel · End-to-end pipeline debugging on serverless compute

### How to Run

1. Upload `datasets/` into a Unity Catalog volume.
2. Update `BASE_PATH` in `00_setup` if the upload path differs.
3. Run notebooks in order: `00_setup` → `01_bronze` → `02_silver_stage1` → `03_silver_stage2_scd2` → `04_gold`.
4. Verify results in **Catalog → retail_demo → gold** and via the sanity-check cells included in each notebook.

Full write-up: see `README.md` and `Final_Project_Report.pdf` inside the project folder.

---

# Tools & Technologies

**Programming & Analysis:** Python 3 · Pandas · NumPy · Jupyter Notebook · Apache Spark (PySpark)

**Database & Querying:** MySQL · SQLite · MySQL Workbench

**Cloud & Data Engineering:** Microsoft Azure · Azure Data Factory · Azure Blob Storage · Azure IAM / RBAC · Apache Spark · Delta Lake · Databricks (Unity Catalog, Auto Loader, Serverless Compute)

**Documentation:** Markdown · PDF Reports · Word Documents (.docx)

---

## Learning Outcomes

Through this internship, I have gained hands-on experience in:

- Data Cleaning and Preprocessing
- Exploratory Data Analysis (EDA)
- SQL Query Development & Relational Database Management
- Advanced SQL Techniques (Subqueries, CTEs, Window Functions)
- Customer Segmentation and Business Analytics
- Azure Cloud Resource Provisioning
- Building End-to-End Data Pipelines with ADF
- IAM Role-Based Access Control (RBAC)
- Apache Spark Fundamentals & Architecture
- Spark DataFrame Operations, Aggregation, GroupBy
- Schema Management and Data Validation
- File Format Optimization (CSV vs Parquet), Predicate Pushdown
- Spark ETL Pipeline Development
- Delta Lake Fundamentals & ACID Transactions
- Incremental Data Processing & MERGE (Upsert) Operations
- Slowly Changing Dimensions — SCD Type 1 & SCD Type 2
- CLI Tool Development & Edge Case Testing
- Cohort / Retention Analysis
- Medallion Architecture (Bronze / Silver / Gold)
- Unity Catalog, Auto Loader, and Schema Evolution
- End-to-End Production-Style Data Pipeline Design & Debugging