USE healthcare_project;

DROP TABLE IF EXISTS stg_healthcare_cleanfinal;

CREATE TABLE stg_healthcare_cleanfinal AS
SELECT
 CONCAT(
    UPPER(LEFT(SUBSTRING_INDEX(TRIM(`Name`), ' ', 1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(`Name`), ' ', 1), 2)),
    ' ',
    UPPER(LEFT(SUBSTRING_INDEX(TRIM(`Name`), ' ', -1), 1)),
    LOWER(SUBSTRING(SUBSTRING_INDEX(TRIM(`Name`), ' ', -1), 2))
  ) AS Name,

  CASE
    WHEN TRIM(`Age`) REGEXP '^[0-9]+$' THEN CAST(TRIM(`Age`) AS UNSIGNED)
    ELSE NULL
  END AS `Age`,

  CASE
    WHEN LOWER(TRIM(`Gender`)) IN ('m', 'male') THEN 'Male'
    WHEN LOWER(TRIM(`Gender`)) IN ('f', 'female') THEN 'Female'
    ELSE 'Unknown'
  END AS `Gender`,

  UPPER(TRIM(`Blood Type`)) AS `Blood Type`,

  TRIM(`Medical Condition`) AS `Medical Condition`,
  TRIM(`Doctor`) AS `Doctor`,
  TRIM(`Hospital`) AS `Hospital`,
  TRIM(`Insurance Provider`) AS `Insurance Provider`,

  STR_TO_DATE(TRIM(`Date of Admission`), '%Y-%m-%d') AS `Date of Admission`,
  STR_TO_DATE(TRIM(`Discharge Date`), '%Y-%m-%d') AS `Discharge Date`,

  TRIM(`Admission Type`) AS `Admission Type`,
  TRIM(`Medication`) AS `Medication`,
  TRIM(`Test Results`) AS `Test Results`,

  CASE
    WHEN `Billing Amount` IS NULL OR TRIM(`Billing Amount`) IN ('', 'N/A', 'NULL', '-') THEN NULL
    ELSE CAST(REPLACE(REPLACE(TRIM(`Billing Amount`), '$', ''), ',', '') AS DECIMAL(12,2))
  END AS `Billing Amount`,

  -- Extra clean field we add (new column)
  CASE
    WHEN STR_TO_DATE(TRIM(`Date of Admission`), '%Y-%m-%d') IS NULL THEN NULL
    WHEN STR_TO_DATE(TRIM(`Discharge Date`), '%Y-%m-%d') IS NULL THEN NULL
    ELSE DATEDIFF(
      STR_TO_DATE(TRIM(`Discharge Date`), '%Y-%m-%d'),
      STR_TO_DATE(TRIM(`Date of Admission`), '%Y-%m-%d')
    )
  END AS `LOS Days`,

  CASE
    WHEN STR_TO_DATE(TRIM(`Date of Admission`), '%Y-%m-%d') IS NULL THEN 1
    WHEN STR_TO_DATE(TRIM(`Discharge Date`), '%Y-%m-%d') IS NULL THEN 0
    WHEN STR_TO_DATE(TRIM(`Discharge Date`), '%Y-%m-%d') < STR_TO_DATE(TRIM(`Date of Admission`), '%Y-%m-%d') THEN 1
    ELSE 0
  END AS `Bad Date Flag`
FROM healthcare_dataset;
