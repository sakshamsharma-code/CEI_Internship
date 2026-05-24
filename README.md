# Celebal Excellence Internship

This repository contains all assignments and work submitted during my Celebal Excellence Internship for the Data Engineering domain. Each week covers different concepts and is organized in its own folder.

---

## Repository Structure

```
├── Week-1/
│   ├── assignment.ipynb
│   ├── cleaned_dataset.csv
│   └── Combined_dataset.csv
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

## Tools & Libraries

- Python 3
- Pandas
- NumPy
- Jupyter Notebook

---

*This repository will be updated weekly as new assignments are completed.*
