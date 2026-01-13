# 🏥 Hospital Admissions Analytics (MySQL)

A full SQL portfolio project that transforms raw hospital admissions data into a clean staging dataset and reusable KPI reporting views.  
This project focuses on **healthcare operations + billing analytics**, including **trend reporting**, **outlier detection**, and **hospital performance benchmarking**.

---

## 📌 Project Goals
- Clean and standardize raw hospital admissions data
- Create analysis-ready fields like **Length of Stay (LOS)**
- Build reusable KPI views for operational and financial reporting
- Identify high-cost and long-stay admissions using percentile-based outlier logic
- Deliver executive-style reporting tables that can plug into dashboards

---

## 📊 Dataset Overview
The dataset includes hospital admission records with fields such as:

- Patient: Name, Age, Gender, Blood Type  
- Clinical: Medical Condition, Medication, Test Results  
- Operational: Date of Admission, Discharge Date, Admission Type, Room Number  
- Financial: Insurance Provider, Billing Amount  
- Organization: Hospital, Doctor  

**Rows:** ~55,500

---

## 🧱 Project Architecture (Real-World SQL Workflow)

### 1) Raw Layer
**Table:** `healthcare_dataset`  
- Imported directly from CSV
- Kept unchanged as the “source of truth”

### 2) Staging Layer (Cleaned + Standardized)
**Table:** `stg_healthcare_cleanfinal`  
Transformations applied:
- Trimmed text fields for consistency
- Standardized gender values (`Male`, `Female`, `Unknown`)
- Converted admission/discharge fields into real `DATE` values
- Converted billing amount into numeric `DECIMAL`
- Created:
  - **LOS Days** (Length of Stay)
  - **Bad Date Flag** (date quality check)

### 3) Reporting Layer (KPI Views)
Reusable views created for analysis:
- `vw_hospital_kpis` → hospital-level admissions, billing, LOS performance
- `vw_insurance_kpis` → insurance provider billing and LOS performance
- `vw_department_kpis` → medical condition KPIs (volume, cost, LOS)
- `vw_top_conditions_by_hospital` → top 3 medical conditions per hospital (ranking)
- `vw_admission_outliers` → top 1% billing and LOS outliers (percentile logic)
- `vw_monthly_trends` → month-over-month admissions and billing trends

---

## 📈 Key Business Questions Answered
- Which hospitals generate the highest total billing?
- Which hospitals have the longest average patient stays?
- Which insurance providers account for the most total billing?
- What are the top medical conditions treated per hospital?
- Which admissions fall into the top 1% of:
  - Billing Amount (high-cost cases)
  - LOS Days (long-stay cases)
- How do admissions and billing change month over month?

---

## 🧠 Skills Demonstrated
- SQL data cleaning and standardization
- Data type conversion (TEXT → DATE / DECIMAL)
- KPI design for healthcare operations and finance
- Window functions:
  - `ROW_NUMBER()` for ranking
  - `NTILE()` for percentile outlier detection
- Reusable reporting via SQL views
- Business-focused analytics storytelling

---

## 🛠️ How to Run (MySQL)
1. Import the CSV into:
   - `healthcare_project.healthcare_dataset`

2. Run the SQL scripts in this order:
- `02_staging_clean.sql`
- `03_kpi_views.sql`
- `04_advanced_views.sql`

3. Query the views for reporting:
```sql
SELECT * FROM vw_hospital_kpis LIMIT 10;
SELECT * FROM vw_insurance_kpis LIMIT 10;
SELECT * FROM vw_monthly_trends;
```
## 🧾 Executive Summary

This project delivers a hospital admissions analytics reporting layer built in **MySQL**, designed to support both **operational monitoring** and **financial performance tracking**.

Using ~55,500 admission records, the dataset was cleaned into a standardized staging table and transformed into reusable KPI views that answer executive-level questions such as:

- Which hospitals generate the highest total billing and volume of admissions?
![Dirty_Data](https://github.com/abdulhaire567/Q1-Executive-Sales-Summary/blob/092422b4aa16b0a1191d0a876c24b105c35b3b0e/dirtydatasett.png)
- Which insurance providers account for the most total billed amounts?
- What medical conditions are most common across hospitals?
- Which admissions fall into the highest-cost and longest-stay outlier groups?
- How do admissions, billing, and length-of-stay metrics trend month-over-month?

The final deliverable includes a clean staging layer (`stg_healthcare_cleanfinal`) and multiple reporting views (`vw_hospital_kpis`, `vw_insurance_kpis`, `vw_monthly_trends`, etc.) that can be used directly for dashboards and business reporting.


## 📸 Project Outputs (Screenshots)

**Sample Dirty Dataset**
![Dirty_Data](https://github.com/abdulhaire567/Q1-Executive-Sales-Summary/blob/092422b4aa16b0a1191d0a876c24b105c35b3b0e/dirtydatasett.png)

**Sample Cleaned Data into table**
![Cleaned Data into table](https://github.com/abdulhaire567/Q1-Executive-Sales-Summary/blob/9e69a2e1db6ab0750baf74f57705ce399a321d39/tablee.png)

**PivotTable for Product Analysis, Slicers showing interactive filtering and pivot chart**
![Pivot Table](https://github.com/abdulhaire567/Q1-Executive-Sales-Summary/blob/317f96534c87fcba42d225bb8f07daa7fac5644b/pivot_chart.png)
![Top Conditions](screenshots/05_top_conditions.png)

### Monthly Trends
![Monthly Trends](screenshots/06_monthly_trends.png)
