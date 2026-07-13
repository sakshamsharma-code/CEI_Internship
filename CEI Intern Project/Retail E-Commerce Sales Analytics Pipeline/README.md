# Retail E-commerce Data Pipeline - Databricks + Delta Lake + Medallion Architecture

## Objective
Build an end-to-end retail e-commerce data pipeline using **Databricks**, **PySpark**, and
**Delta Lake**. The pipeline ingests historical batch data and daily incremental data,
processes it through a **Medallion Architecture (Bronze → Silver → Gold)**, tracks
historical changes to customers and products using **SCD Type 2**, and produces
analytics-ready Gold tables for business reporting (revenue trends, customer behavior,
product performance).

The pipeline handles real-world data issues: null values, duplicates, invalid dates,
text inside numeric fields, schema changes, and late-arriving data.

---

## Tech Stack
| Tool | Purpose |
|---|---|
| Databricks (Free Edition) | Workspace, notebooks, serverless compute |
| PySpark | Data transformation logic |
| Delta Lake | Storage format — ACID transactions, time travel, schema evolution |
| Unity Catalog | Catalog/schema/volume organization |
| Auto Loader (`cloudFiles`) | Incremental file ingestion |

---

## Medallion Architecture

```
Raw CSV files (Volume)
        |
        v
+--------------------------+
| BRONZE                   |
| Raw ingestion, no clean  |
| audit cols added         |
+--------------------------+
        |
        v
+--------------------------+
| SILVER - Stage 1         |
| Clean / Cast / Dedup     |
| Quarantine bad records   |
+--------------------------+
        |
        v
+--------------------------+
| SILVER - Stage 2         |
| SCD Type 2 dimensions    |
| (customer, product)      |
+--------------------------+
        |
        v
+--------------------------+
| GOLD                     |
| Conformed fact table     |
| Analytics-ready tables   |
+--------------------------+
```

### Bronze
Raw CSVs loaded as-is (all columns as string) into Delta tables. No cleaning, no
casting — this is a historical, replayable archive. Audit columns added:
`source_file`, `ingestion_ts`, `load_type`. Batch files loaded via `spark.read`;
incremental/CDC files loaded via **Auto Loader** with schema evolution enabled
(handles the new `coupon_code` column that appears on day 3).

### Silver Stage 1
Raw strings cast to proper types (dates, numbers). Dirty values (`"unknown"`,
`"bad_amount"`, malformed dates) are handled with `try_cast` / `try_to_date` /
`try_to_timestamp` so bad values become `null` instead of crashing the job.
Records missing required fields are **quarantined** (kept in a separate table,
not deleted). Duplicates are removed by keeping the latest `ingestion_ts` per
business key.

### Silver Stage 2 (SCD Type 2)
Builds `dim_customer_scd2` and `dim_product_scd2`. Initial load creates one
"current" row per entity from the cleaned batch data. Daily CDC files are then
replayed in `effective_date` order using a two-step MERGE: close the currently
active row (`is_current = false`, set `effective_end_date`), then insert a new
row with a fresh surrogate key. Changes are detected via a SHA-256 hash of
tracked columns, so late-arriving or duplicate CDC records don't create false
history.

### Gold
`fact_orders` joins cleaned orders to the SCD2 dimensions using a
**point-in-time date-range join** (order_date between `effective_start_date`
and `effective_end_date`) so each order links to the customer/product state
that was true *at the time of the order*, not the current state. Four
aggregate tables are built on top for reporting: daily sales, category sales,
segment sales, region sales.

---

## Folder Structure

```
CEI_Intern_Project/                              (submission root — zip this whole folder)
├── 00_setup.ipynb                               # catalog/schema/volume + path config
├── 01_bronze.ipynb                              # raw ingestion (batch + Auto Loader)
├── 02_silver_stage1.ipynb                       # clean, cast, dedup, quarantine
├── 03_silver_stage2_scd2.ipynb                  # SCD Type 2 dimensions
├── 04_gold.ipynb                                # fact table + analytics tables
├── README.md
├── Final_Project_Report.pdf                     # evaluation write-up
├── datasets/
│   ├── batch/
│   │   ├── orders_batch.csv
│   │   ├── customers_batch.csv
│   │   ├── products_batch.csv
│   │   └── stores_batch.csv
│   └── incremental/
│       ├── day_2026-04-24/
│       │   ├── orders_incremental_2026-04-24.csv
│       │   ├── customers_cdc_2026-04-24.csv
│       │   └── products_cdc_2026-04-24.csv
│       ├── day_2026-04-25/
│       │   ├── orders_incremental_2026-04-25.csv
│       │   ├── customers_cdc_2026-04-25.csv
│       │   └── products_cdc_2026-04-25.csv
│       └── day_2026-04-26/
│           ├── orders_incremental_2026-04-26.csv     # + coupon_code column (schema change)
│           ├── customers_cdc_2026-04-26.csv
│           └── products_cdc_2026-04-26.csv
└── results_screenshots/
    ├── 00_setup/
    │   └── 01_catalog_schemas_volume_created.png     # output of 00_setup run
    ├── 01_bronze/
    │   ├── 01_bronze_row_counts.png                  # print() output: row counts per table
    │   └── 02_catalog_raw_tables.png                 # Catalog → retail_demo → raw, expanded
    ├── 02_silver_stage1/
    │   ├── 01_orders_clean_vs_quarantine.png         # print() output for orders
    │   ├── 02_customers_clean_vs_quarantine.png      # print() output for customers
    │   ├── 03_products_clean_vs_quarantine.png       # print() output for products
    │   └── 04_catalog_silver_tables.png               # Catalog → retail_demo → silver, expanded
    ├── 03_silver_stage2_scd2/
    │   ├── 01_customer_scd2_history_example.png      # one customer_id, 2+ rows, is_current visible
    │   └── 02_product_scd2_history_example.png       # one product_id, 2+ rows, is_current visible
    ├── 04_gold/
    │   ├── 01_fact_orders_sample.png                 # SELECT * FROM gold.fact_orders LIMIT 10
    │   ├── 02_gold_daily_sales.png
    │   ├── 03_gold_category_sales.png
    │   ├── 04_gold_segment_sales.png
    │   ├── 05_gold_region_sales.png
    │   ├── 06_describe_history.png                   # DESCRIBE HISTORY output
    │   └── 07_time_travel_query.png                  # VERSION AS OF 0 vs latest, side by side
    └── 05_catalog_overview/
        └── 01_all_tables_all_schemas.png             # Catalog Explorer, raw+silver+gold all expanded

/Volumes/retail_demo/raw/retail_files/            (Unity Catalog Volume - raw files, on Databricks)
├── datasets/
│   ├── batch/
│   │   ├── orders_batch.csv
│   │   ├── customers_batch.csv
│   │   ├── products_batch.csv
│   │   └── stores_batch.csv
│   └── incremental/
│       ├── day_2026-04-24/
│       │   ├── orders_incremental_2026-04-24.csv
│       │   ├── customers_cdc_2026-04-24.csv
│       │   └── products_cdc_2026-04-24.csv
│       ├── day_2026-04-25/  (same 3 file types)
│       └── day_2026-04-26/  (same 3 file types, + coupon_code column)
├── _checkpoints/                       # Auto Loader streaming checkpoints
└── _schemas/                           # Auto Loader schema tracking
```

### `results_screenshots/` — what to capture, notebook by notebook

**`00_setup/`**
| # | File | What it shows |
|---|---|---|
| 1 | `01_catalog_schemas_volume_created.png` | Output of running `00_setup` — confirms catalog/schemas/volume created, and the printed `BATCH_PATH` / `INCR_PATH` |

**`01_bronze/`**
| # | File | What it shows |
|---|---|---|
| 1 | `01_bronze_row_counts.png` | `01_bronze` notebook output — row counts for each bronze table after ingestion |
| 2 | `02_catalog_raw_tables.png` | Catalog Explorer → `retail_demo` → `raw` schema expanded, all 7 tables visible |

**`02_silver_stage1/`**
| # | File | What it shows |
|---|---|---|
| 1 | `01_orders_clean_vs_quarantine.png` | Output cell: `orders clean: N \| quarantined: N` |
| 2 | `02_customers_clean_vs_quarantine.png` | Output cell: same for customers |
| 3 | `03_products_clean_vs_quarantine.png` | Output cell: same for products |
| 4 | `04_catalog_silver_tables.png` | Catalog Explorer → `retail_demo` → `silver` schema expanded |

**`03_silver_stage2_scd2/`**
| # | File | What it shows |
|---|---|---|
| 1 | `01_customer_scd2_history_example.png` | `SELECT * FROM retail_demo.silver.dim_customer_scd2 WHERE customer_id = '<pick one with 2+ rows>'` — must show `effective_start_date`, `effective_end_date`, `is_current` differing across rows |
| 2 | `02_product_scd2_history_example.png` | Same query on `dim_product_scd2` for a product with 2+ history rows |

**`04_gold/`**
| # | File | What it shows |
|---|---|---|
| 1 | `01_fact_orders_sample.png` | `SELECT * FROM retail_demo.gold.fact_orders LIMIT 10` |
| 2-5 | `02_gold_daily_sales.png` ... `05_gold_region_sales.png` | `SELECT * FROM retail_demo.gold.<table>` for each of the 4 summary tables |
| 6 | `06_describe_history.png` | `DESCRIBE HISTORY retail_demo.gold.fact_orders` |
| 7 | `07_time_travel_query.png` | `fact_orders` queried `VERSION AS OF 0` vs. the latest version, both results visible |

**`05_catalog_overview/`**
| # | File | What it shows |
|---|---|---|
| 1 | `01_all_tables_all_schemas.png` | Catalog Explorer with `raw`, `silver`, and `gold` all expanded together — single-glance proof all 17 tables exist |

Keep file names exactly as listed — the report will reference them by this exact path.

---

## Tables Produced

**Catalog:** `retail_demo`

| Schema | Table | Description |
|---|---|---|
| raw | bronze_orders, bronze_customers, bronze_products, bronze_stores | Raw batch tables |
| raw | bronze_orders_incremental, bronze_customers_cdc, bronze_products_cdc | Raw incremental/CDC tables |
| silver | silver1_orders_clean / _quarantine | Cleaned + rejected orders |
| silver | silver1_customers_clean / _quarantine | Cleaned + rejected customers |
| silver | silver1_products_clean / _quarantine | Cleaned + rejected products |
| silver | dim_store | Deduplicated store dimension |
| silver | dim_customer_scd2 | SCD Type 2 customer dimension |
| silver | dim_product_scd2 | SCD Type 2 product dimension |
| gold | fact_orders | Conformed fact table with surrogate keys |
| gold | gold_daily_sales | Orders, revenue, units, AOV by day |
| gold | gold_category_sales | Orders, revenue, units by product category |
| gold | gold_segment_sales | Unique customers, orders, revenue by segment |
| gold | gold_region_sales | Orders, revenue, units by store region |

---

## Delta Lake Features Demonstrated
- **Table history** — `DESCRIBE HISTORY retail_demo.gold.fact_orders`
- **Time travel** — querying `fact_orders` `versionAsOf 0` vs latest
- **Schema evolution** — `coupon_code` column (new on day 3) auto-accepted via
  `cloudFiles.schemaEvolutionMode = "addNewColumns"` and `mergeSchema = "true"`

---

## Known Data Quality Findings
- ~720 orders (4%) have a customer_sk of null: customer exists in the dimension,
  but the order_date falls before the customer's earliest known effective_start_date
  (order predates signup in source data).
- ~536 orders (3%) have a product_sk of null: 69 are the same date-mismatch issue;
  16 reference products that were quarantined in Silver Stage 1 due to invalid pricing.

---

## How to Run
1. Upload `datasets/` into the Unity Catalog volume path shown above.
2. Open `00_setup` and update `BASE_PATH` if your upload path differs.
3. Run notebooks in order, top to bottom (or "Run All" per notebook):
   `00_setup` → `01_bronze` → `02_silver_stage1` → `03_silver_stage2_scd2` → `04_gold`
4. Verify results in **Catalog → retail_demo → gold** and using the sanity-check
   cells included in each notebook.