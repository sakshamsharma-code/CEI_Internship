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
│   ├── Week4_Azure_ADF_Assignment.docx
│   └── Sample - Superstore.csv
│
├── Week 5 Assignment
│   ├── data
│   │   └── dataset.csv
│   ├── notebook
│   │   └── spark_basics.ipynb
│   ├── output
│   │   └── results.csv
│   └── README.md
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

The dataset includes Customer Information, Product Information, Order Details, Shipping Details, Sales Metrics, Profit Metrics, and Regional Information across four US regions: East, West, Central, and South.

### What I Did

#### Database Setup

1. Created a MySQL database named `superstore_db`.
2. Designed and created the `superstore` table with 21 attributes.
3. Imported the Superstore dataset into MySQL.
4. Verified successful loading using row counts and sample queries.

#### Data Exploration

Examined table schema using `DESCRIBE` and `SHOW COLUMNS`, and retrieved sample records using `SELECT` and `LIMIT`.

#### Filtering, Aggregation & Business Analysis

Applied SQL filters on Region, Category, Sales Amount, Order Date, Profit, and Discount. Used aggregate functions (`SUM`, `AVG`, `COUNT`, `MIN`, `MAX`) and `ORDER BY` / `LIMIT` to identify top products, customers, and categories.

Performed business analysis on Monthly Sales Trends, Customer Purchase Behavior, Category Performance, Regional Sales Distribution, Product Profitability, and Customer Segmentation.

### Output

| File                                        | Description                                               |
| ------------------------------------------- | --------------------------------------------------------- |
| `Assignment 2 (Query + Brief Insights).pdf` | SQL queries, outputs, observations, and business insights |
| `Assignment_2.sql`                          | Assignment queries and solutions                          |
| `Assignment-2_Superstore_SQL_Analysis.pdf`  | Complete SQL analysis report                              |
| `Superstore_SQL_Analysis.sql`               | Full SQL script containing all analysis queries           |

### Key Insights

* Technology products generated significant revenue contribution.
* Monthly sales trends highlighted seasonal fluctuations.
* Certain products generated high sales but lower profits due to heavy discounts.
* Regional performance varied significantly across different categories.

### SQL Concepts Practiced

`SELECT` · `WHERE` · `ORDER BY` · `GROUP BY` · `HAVING` · Aggregate Functions · Date Functions · Data Validation · Business Analytics

---

# Week 3 — Advanced SQL: Subqueries, CTEs & Window Functions

**Objective:** Use advanced SQL techniques such as Subqueries, Common Table Expressions (CTEs), and Window Functions to perform customer-centric sales analysis on the Superstore dataset.

**Dataset:** Superstore Sales Dataset (2014–2017)
**RDBMS Used:** MySQL

### What I Did

#### Database Design & Data Preparation

1. Created a staging table `superstore_raw` and imported CSV using `LOAD DATA INFILE`.
2. Performed data transformation using `STR_TO_DATE()`.
3. Normalized the dataset into `customers`, `products`, and `orders` tables.
4. Removed duplicate records using `SELECT DISTINCT`.

#### Subquery & CTE Analysis

* Identified orders with above-average sales using subqueries.
* Retrieved the highest sales order per customer using correlated subqueries.
* Used CTEs to calculate total sales per customer and identify above-average buyers.

#### Window Function Analysis

* `RANK()` — Ranked customers by total sales and identified the Top 3.
* `ROW_NUMBER()` — Generated sequential order numbers per customer using `PARTITION BY`.

#### Mini Project — Customer Sales Insights

1. Top 5 Customers by Revenue
2. Bottom 5 Customers by Revenue
3. Customers with Only One Order
4. Customers with Above-Average Sales
5. Highest Order Value per Customer

### Output

| File                                | Description                                                             |
| ----------------------------------- | ----------------------------------------------------------------------- |
| `Week_3_Assignment.pdf`             | Complete assignment report with queries, outputs, and business insights |
| `Week_3_Assignment_SQL_Queries.sql` | SQL script containing all Subquery, CTE, and Window Function queries    |
| `Sample - Superstore.csv`           | Dataset used for analysis                                               |

### Key Insights

* Top customers generated between **$14K and $25K** in total sales.
* Bottom customers contributed less than **$25** in total sales — potential churn risk.
* Only **12 out of 793 customers** placed a single order.
* High-value orders from customers like Sean Miller and Tamara Chand heavily influence total revenue.

### SQL Concepts Practiced

`Subqueries` · `Correlated Subqueries` · `CTEs` · `RANK()` · `ROW_NUMBER()` · `PARTITION BY` · `Aggregate Functions` · Customer Analytics · Business Intelligence

---

# Week 4 — Azure Cloud Fundamentals & Data Pipeline using ADF

**Objective:** Understand Azure cloud concepts and build a complete end-to-end data pipeline using Azure Storage Account and Azure Data Factory (ADF).

**Dataset:** Superstore Sales Dataset
**Platform:** Microsoft Azure (Free Student Subscription)

### What I Did

#### Azure Environment Setup

1. Created a **Resource Group** (`rg-celebal`) on the Azure Portal.
2. Provisioned a **Storage Account** (`celebalweek4storage`) with LRS redundancy.
3. Created two **Blob Containers**:
   * `superstore-input` — source container (uploaded Superstore CSV here)
   * `superstore-output` — destination container for pipeline output

#### Azure Data Factory Setup

1. Created an ADF instance (`adf-celebal-4thweek`) and launched ADF Studio.
2. Explored the three core ADF UI sections: **Author**, **Monitor**, and **Manage**.
3. Created a **Linked Service** (`ls_blob_superstore`) connecting ADF to Blob Storage using Account Key authentication.
4. Defined two **Datasets** in DelimitedText format:
   * `ds_source_superstore` — points to the Superstore CSV in `superstore-input`
   * `ds_destination_superstore` — points to `superstore_processed.csv` in `superstore-output`

#### Pipeline Development

1. Created pipeline `pl_superstore_pipeline` on the ADF canvas.
2. Added a **Get Metadata** activity to retrieve file properties: `itemName`, `size`, `lastModified`, `columnCount`.
3. Added a **Copy Data** activity connected via a success dependency arrow.
4. Configured source and sink datasets, imported 21-column schema mapping, and set fault tolerance for malformed rows.

#### Pipeline Execution & Monitoring

1. Ran the pipeline using **Debug** mode.
2. Monitored execution in the Output tab — both activities completed successfully in under 35 seconds.
3. Verified `superstore_processed.csv` was created in the `superstore-output` container with all **9,994 rows** copied.

#### IAM Role Assignment

Assigned the following roles on the Storage Account:

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

| File                              | Description                                              |
| --------------------------------- | -------------------------------------------------------- |
| `Week4_Azure_ADF_Assignment.docx` | Complete assignment report with screenshots and summary  |
| `Sample - Superstore.csv`         | Source dataset uploaded to Blob Storage                  |

### Key Learnings

* Set up the full Azure cloud environment from scratch — Resource Group, Storage Account, Blob Containers.
* Understood how ADF Linked Services abstract connection credentials from pipeline logic.
* Get Metadata + Copy Data chaining enforces a validation-before-copy pattern used in real pipelines.
* IAM Managed Identity access is the recommended secure approach over hardcoded keys.
* Fault tolerance settings (`Skip incompatible rows`) are essential for real-world CSV datasets with inconsistencies.

### Azure Services Used

`Azure Portal` · `Resource Groups` · `Storage Account` · `Blob Storage` · `Azure Data Factory` · `Linked Services` · `Datasets` · `Pipelines` · `IAM / RBAC`

---

# Tools & Technologies

### Programming & Analysis

* Python 3
* Pandas
* NumPy
* Jupyter Notebook
* Apache Spark (PySpark)

### Database & Querying

* MySQL
* MySQL Workbench

### Cloud & Data Engineering

* Microsoft Azure
* Azure Data Factory
* Azure Blob Storage
* Azure IAM / RBAC
* Apache Spark

### Documentation

* Markdown
* PDF Reports
* Word Documents (.docx)

---

## Learning Outcomes

Through this internship, I have gained hands-on experience in:

* Data Cleaning and Preprocessing
* Exploratory Data Analysis (EDA)
* SQL Query Development
* Relational Database Management
* Advanced SQL Techniques (Subqueries, CTEs, Window Functions)
* Customer Segmentation and Business Analytics
* Azure Cloud Resource Provisioning
* Building End-to-End Data Pipelines with ADF
* IAM Role-Based Access Control (RBAC)
* Pipeline Monitoring and Execution on Azure
* Apache Spark Fundamentals
* Spark DataFrame Operations
* Data Cleaning & Transformation using PySpark
* Data Aggregation and GroupBy Operations
* Schema Management and Data Validation
* Spark ETL Pipeline Development

---

# Week 5 — Apache Spark Fundamentals & Data Processing

**Objective:** Understand Apache Spark fundamentals and perform data cleaning, transformation, filtering, grouping, and aggregation using PySpark DataFrames.

**Dataset:** CSV Dataset
**Platform:** Apache Spark (PySpark)

### What I Did

#### Spark Fundamentals

1. Understood the limitations of traditional MapReduce and how Spark overcomes them using in-memory processing.
2. Learned Spark architecture including Driver, Executors, Cluster Manager, and execution flow.
3. Explored Spark DataFrames, immutability, lazy evaluation, and DAG (Directed Acyclic Graph) execution.

#### Spark Environment Setup

1. Configured a PySpark environment using Google Colab.
2. Imported the required Spark SQL libraries.
3. Created a Spark Session for DataFrame operations.
4. Loaded a CSV dataset into a Spark DataFrame.

#### Data Exploration

1. Inspected the dataset using:
   * `show()`
   * `printSchema()`
   * `columns`
   * `dtypes`
2. Verified the schema and examined sample records before processing.

#### Data Cleaning & Transformation

1. Removed duplicate records using `dropDuplicates()`.
2. Handled missing values using both:
   * `.na.drop()`
   * `.na.fill()`
3. Identified inconsistent or invalid records.
4. Renamed columns using `withColumnRenamed()`.
5. Converted column data types using `cast()`.

#### Filtering & Aggregation

1. Applied filtering conditions based on:
   * Age
   * Category
   * Region
2. Performed aggregations using:
   * `count()`
   * `sum()`
   * `avg()`
   * `min()`
   * `max()`
3. Grouped records using `groupBy()` for category-wise and store-wise analysis.
4. Applied conditions on aggregated results using DataFrame operations.

#### Spark Processing Concepts

1. Understood the difference between narrow and wide transformations.
2. Learned how shuffle operations occur during grouping and aggregation.
3. Explored schema handling and type conversion for reliable data processing.

#### End-to-End Spark Pipeline

Built a complete Spark data processing workflow consisting of:

1. Loading the dataset
2. Data cleaning
3. Data transformation
4. Data filtering
5. Aggregation and grouping
6. Output generation

### Output

| File | Description |
|----------------------------------|-------------------------------------------------------------|
| `spark_basics.ipynb` | Complete PySpark notebook containing all assignment tasks |
| `results.csv` | Processed dataset generated after Spark transformations |
| `README.md` | Assignment documentation and execution guide |

### Key Learnings

* Understood why Apache Spark is preferred over MapReduce for large-scale data processing.
* Learned to work with immutable Spark DataFrames and lazy evaluation.
* Performed data cleaning, filtering, schema transformation, and aggregation using PySpark.
* Gained practical experience with groupBy operations and aggregate functions.
* Understood shuffle operations and their impact on Spark performance.
* Built a complete end-to-end data processing pipeline using Spark DataFrames.

### Spark Concepts Practiced

`Apache Spark` · `PySpark` · `Spark Session` · `DataFrames` · `Lazy Evaluation` · `Immutability` · `Schema Handling` · `Data Cleaning` · `Filtering` · `Aggregation` · `groupBy()` · `Shuffle Operations` · `Wide Transformations` · `Data Processing Pipeline`

---

*This repository will be updated weekly as new assignments and projects are completed throughout the Celebal Excellence Internship.*
