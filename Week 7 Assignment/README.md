# Delta Lake Assignment — Week 7: Incremental Data Processing using Delta Lake

## Objective

Perform incremental data processing using Delta Lake by loading datasets into Delta tables, performing data cleaning, applying MERGE operations for updates and inserts, validating the results, and understanding Slowly Changing Dimensions (SCD) concepts.

---

## Assignment Overview

This assignment covers two parts:

**Part 1 — Python & Pandas Basics:** Loading a CSV dataset, exploring it, handling missing values, filtering/selecting data, removing duplicates, creating a derived column (`total_amount`), and exporting the cleaned dataset as a new CSV.

**Part 2 — Delta Lake MERGE Implementation:** Loading the cleaned data into a Delta Table, simulating incremental data, applying `MERGE` (upsert) operations for SCD Type 1, validating results, and implementing SCD Type 2 to track historical changes.

---

## What I Learned

* Understood the fundamentals of Delta Lake and ACID transactions.
* Learned how Delta Tables manage reliable and scalable incremental data processing.
* Performed data cleaning using Pandas — handling missing values and duplicates.
* Created a derived column and exported a cleaned dataset to CSV.
* Created an incremental dataset to simulate real-world updates and new records.
* Applied `MERGE` operations to update existing records and insert new ones (SCD Type 1).
* Implemented SCD Type 2 to preserve historical versions of records.
* Validated processed data using row-count, duplicate, and null checks.
* Built a complete, end-to-end Delta Lake data processing pipeline.

---

## Tasks Performed

### Part 1: Python & Pandas Basics

* Loaded `customer_master.csv` into a Pandas DataFrame.
* Explored data using `head()`, `tail()`, `shape`, `columns`, and `dtypes`.
* Identified and handled missing values (`fillna()` for numeric and categorical columns).
* Filtered rows (e.g., Region = West) and selected specific columns.
* Removed duplicate records using `drop_duplicates()`.
* Created a derived column: `total_amount = Sales * Quantity`.
* Saved the cleaned dataset as `customer_master_cleaned.csv`.

### Part 2: Delta Lake Fundamentals

* Understood Delta Lake architecture and the advantages of Delta Tables over plain data lakes.
* Explored ACID transactions and data reliability guarantees.

### Data Loading (Delta)

* Loaded the cleaned master dataset into a Delta Table (`week_7_db.customer_master`).
* Casted and cleaned column types, added `total_amount`.
* Examined schema, column names, and data types.

### Incremental Data Processing

* Created a second dataset (`customer_incremental.csv`-style) simulating:
  * 20 updated existing records (Sales +10%)
  * 10 new customer records
* Prepared the incremental data for the `MERGE` operation.

### MERGE Operation — SCD Type 1

* Used `DeltaTable.merge()` with `whenMatchedUpdate` and `whenNotMatchedInsertAll`.
* Updated existing records and inserted new records in a single ACID operation.

### Validation

* Verified row counts before and after MERGE.
* Checked for duplicate `Row_ID`s (confirmed 0 duplicates).
* Checked for nulls in key columns.
* Inspected updated and newly inserted records.

### SCD Type 2 — Historical Tracking

* Added `is_current`, `effective_date`, and `end_date` columns.
* Expired old records (`is_current = false`, `end_date` set) on match.
* Appended new/incremental records as current rows.
* Exported the SCD2 result as `customer_master_scd2.csv`.

### End-to-End Data Processing Pipeline

Built a complete Delta Lake workflow consisting of:

1. Load & Clean Data (Pandas)
2. Load into Delta Table
3. Create Incremental Dataset
4. MERGE Operation (SCD Type 1)
5. Validation
6. SCD Type 2 Implementation
7. Final Output & Summary

---

## Project Structure

```text
Week 7 Assignment
│
├── data
│   ├── customer_master.csv
│   ├── customer_incremental.csv
│   ├── customer_master_cleaned.csv
│   └── customer_master_scd2.csv
│
├── notebook
│   └── delta_scd_assignment.ipynb
│
├── screenshots
│   ├── data_loading
│   │   ├── 01_data_loaded.png
│   │   ├── 02_data_explored.png
│   │   ├── 03_derived_column.png
│   │   └── 04_saved_csv.png
│   ├── data_cleaning
│   │   ├── 01_missing_values.png
│   │   ├── 02_filter_select.png
│   │   └── 03_duplicates.png
│   ├── scd1
│   │   ├── 01_master_table_created.png
│   │   ├── 02_incremental_created.png
│   │   └── 03_merge_execution.png
│   ├── scd2
│   │   └── scd2_implementation.png
│   ├── validation
│   │   └── validation.png
│   └── final_output
│       ├── 01_summary.png
│       ├── 02_summary_stats.png
│       └── 03_final_table_category_wise.png
│
├── report
│   └── assignment_summary.pdf
│
└── README.md
```

---

## Technologies Used

* Apache Spark
* PySpark
* Delta Lake
* Python / Pandas
* Databricks
* Jupyter Notebook

---

## Output

| File                           | Description                                                       |
| ------------------------------ | ----------------------------------------------------------------- |
| `delta_scd_assignment.ipynb`   | Complete notebook containing all Part 1 & Part 2 assignment tasks |
| `customer_master_cleaned.csv`  | Cleaned dataset after Pandas preprocessing (Part 1 output)        |
| `customer_master_scd2.csv`     | Final dataset after SCD Type 2 MERGE processing (Part 2 output)   |
| `screenshots/`                 | Screenshots of each major implementation step                     |
| `assignment_summary.pdf`       | Brief report summarizing the complete assignment                  |
| `README.md`                    | Assignment documentation and execution guide                      |

---

## Key Learning Outcomes

* Python & Pandas data exploration and cleaning
* Delta Lake Fundamentals & ACID Transactions
* Incremental Data Processing
* MERGE Operation (Upsert)
* Slowly Changing Dimensions — SCD Type 1 & SCD Type 2
* Data Validation (row count, duplicates, nulls)
* End-to-End Delta Lake Data Processing Pipeline

---

## How to Run

1. Open `delta_scd_assignment.ipynb` in Databricks (recommended, for native Delta Lake support) or Jupyter Notebook.
2. Ensure PySpark and Delta Lake libraries are available in the environment.
3. Make sure the required datasets are accessible:
   * `customer_master.csv`
   * `customer_incremental.csv`
4. Run all notebook cells sequentially — Part 1 (Pandas) followed by Part 2 (Delta Lake).
5. Review the execution results, validation outputs, and SCD2 history.
6. Processed CSVs, screenshots, and the report will be available in their respective folders.
