# Spark Assignment — Week 5: Data Cleaning, Transformation & Aggregation

## Objective

Learn the fundamentals of Apache Spark and perform data cleaning, transformation, filtering, grouping, and aggregation using PySpark DataFrames.

---

## Assignment Overview

This assignment focuses on understanding Apache Spark fundamentals and applying DataFrame operations to clean, transform, and analyze structured data. It demonstrates a complete workflow including data loading, cleaning, filtering, schema transformation, aggregation, and building an end-to-end Spark data processing pipeline.

---

## What I Learned

- Understood the limitations of MapReduce and the advantages of Apache Spark.
- Learned how Spark uses in-memory processing for faster execution.
- Explored Spark DataFrames, immutability, lazy evaluation, and DAG execution.
- Performed data cleaning and preprocessing using PySpark.
- Applied filtering, transformations, and schema modifications.
- Performed aggregations and groupBy operations for data analysis.
- Understood shuffle operations and wide transformations.
- Built a complete Spark data processing pipeline.

---

## Tasks Performed

### Spark Fundamentals

- Compared Apache Spark with MapReduce.
- Learned Spark architecture and execution model.
- Explored Spark DataFrames and immutable data structures.

### Data Loading

- Created a Spark Session using PySpark.
- Loaded the CSV dataset into a Spark DataFrame.
- Examined schema, column names, and data types.

### Data Cleaning

- Removed duplicate records.
- Handled missing values using `.na.drop()` and `.na.fill()`.
- Identified inconsistent or invalid records.

### Data Transformation

- Renamed columns where required.
- Converted data types using `cast()`.
- Applied filtering conditions based on age, category, and region.

### Aggregation & Analysis

Performed statistical analysis using:

- `count()`
- `sum()`
- `avg()`
- `min()`
- `max()`

Grouped data using `groupBy()` to generate summarized insights.

### Spark Processing Concepts

- Understood Narrow and Wide Transformations.
- Learned how Shuffle operations occur during grouping and aggregation.
- Explored schema handling and DataFrame transformations.

### End-to-End Data Processing Pipeline

Built a complete Spark workflow consisting of:

1. Load Dataset
2. Data Cleaning
3. Data Transformation
4. Data Filtering
5. Aggregation & Analysis
6. Output Generation

---

## Project Structure

```text
Week 5 Assignment
│
├── data
│   └── Superstore_Final.csv
│
├── notebook
│   └── Week_5_Assignment.ipynb
│
├── output
│   └── results.csv
│
└── README.md
```

---

## Technologies Used

- Apache Spark
- PySpark
- Python
- Google Colab
- Jupyter Notebook

---

## Output

| File | Description |
|------|-------------|
| `Week_5_Assignment.ipynb` | Complete PySpark notebook containing all assignment tasks |
| `results.csv` | Processed output generated after Spark transformations |
| `README.md` | Assignment documentation and execution guide |

---

## Key Learning Outcomes

- Apache Spark Fundamentals
- Spark DataFrame Operations
- Data Cleaning & Preprocessing
- Data Transformation
- Filtering & Selection
- Aggregation Functions
- GroupBy Operations
- Schema Handling
- Shuffle Operations
- Wide Transformations
- End-to-End Spark Data Processing Pipeline

---

## How to Run

1. Open `Week_5_Assignment.ipynb` using Google Colab or Jupyter Notebook.
2. Install PySpark (if required).
3. Upload `Superstore_Final.csv` when prompted.
4. Run all notebook cells sequentially.
5. Review the processed output and generated results.