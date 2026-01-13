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
