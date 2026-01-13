DROP VIEW IF EXISTS vw_department_kpis;

CREATE VIEW vw_department_kpis AS
SELECT
  `Medical Condition`,
  COUNT(*) AS total_admissions,
  ROUND(AVG(`Billing Amount`), 2) AS avg_billing,
  ROUND(AVG(`LOS Days`), 2) AS avg_los,
  ROUND(MAX(`Billing Amount`), 2) AS max_billing
FROM stg_healthcare_cleanfinal
GROUP BY `Medical Condition`
ORDER BY total_admissions DESC;

DROP VIEW IF EXISTS vw_hospital_kpis;

CREATE VIEW vw_hospital_kpis AS
SELECT
  `Hospital`,
  COUNT(*) AS total_admissions,
  ROUND(AVG(`Billing Amount`), 2) AS avg_billing,
  ROUND(SUM(`Billing Amount`), 2) AS total_billing,
  ROUND(AVG(`LOS Days`), 2) AS avg_los,
  ROUND(MAX(`Billing Amount`), 2) AS max_billing
FROM stg_healthcare_cleanfinal
GROUP BY `Hospital`
ORDER BY total_billing DESC;

DROP VIEW IF EXISTS vw_insurance_kpis;

CREATE VIEW vw_insurance_kpis AS
SELECT
  `Insurance Provider`,
  COUNT(*) AS total_admissions,
  ROUND(SUM(`Billing Amount`), 2) AS total_billing,
  ROUND(AVG(`Billing Amount`), 2) AS avg_billing,
  ROUND(AVG(`LOS Days`), 2) AS avg_los,
  ROUND(MAX(`Billing Amount`), 2) AS max_billing
FROM stg_healthcare_cleanfinal
GROUP BY `Insurance Provider`
ORDER BY total_billing DESC;

DROP VIEW IF EXISTS vw_top_conditions_by_hospital;

CREATE VIEW vw_top_conditions_by_hospital AS
SELECT
  `Hospital`,
  `Medical Condition`,
  total_admissions,
  total_billing,
  rn AS condition_rank
FROM (
  SELECT
    `Hospital`,
    `Medical Condition`,
    COUNT(*) AS total_admissions,
    ROUND(SUM(`Billing Amount`), 2) AS total_billing,
    ROW_NUMBER() OVER (
      PARTITION BY `Hospital`
      ORDER BY COUNT(*) DESC, SUM(`Billing Amount`) DESC
    ) AS rn
  FROM stg_healthcare_cleanfinal
  GROUP BY `Hospital`, `Medical Condition`
) ranked
WHERE rn <= 3;

DROP VIEW IF EXISTS vw_admission_outliers;

CREATE VIEW vw_admission_outliers AS
SELECT
  `Name`,
  `Hospital`,
  `Doctor`,
  `Medical Condition`,
  `Insurance Provider`,
  `Admission Type`,
  `Date of Admission`,
  `Discharge Date`,
  `LOS Days`,
  `Billing Amount`,
  NTILE(100) OVER (ORDER BY `Billing Amount`) AS billing_percentile,
  NTILE(100) OVER (ORDER BY `LOS Days`) AS los_percentile
FROM stg_healthcare_cleanfinal
WHERE `Billing Amount` IS NOT NULL
  AND `LOS Days` IS NOT NULL;
  
  DROP VIEW IF EXISTS vw_monthly_trends;

CREATE VIEW vw_monthly_trends AS
SELECT
  DATE_FORMAT(`Date of Admission`, '%Y-%m-01') AS month_start,
  COUNT(*) AS admissions,
  ROUND(SUM(`Billing Amount`), 2) AS total_billing,
  ROUND(AVG(`Billing Amount`), 2) AS avg_billing,
  ROUND(AVG(`LOS Days`), 2) AS avg_los
FROM stg_healthcare_cleanfinalhealthcare_dataset
WHERE `Date of Admission` IS NOT NULL
  AND `Billing Amount` IS NOT NULL
GROUP BY DATE_FORMAT(`Date of Admission`, '%Y-%m-01')
ORDER BY month_start;
