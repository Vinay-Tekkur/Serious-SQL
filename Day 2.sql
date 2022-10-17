-- CTE (Common Table Expression)
WITH remove_dups AS (
SELECT DISTINCT * FROM health.user_logs
)
SELECT COUNT(*) FROM remove_dups;

-- Sub query
SELECT COUNT(*) FROM (
SELECT DISTINCT * FROM health.user_logs
)AS subquery;

-- Temp tables
CREATE TEMP TABLE remove_dups_tables AS(
SELECT DISTINCT * FROM health.user_logs)

SELECT COUNT(*) FROM remove_dups_tables

-- Exercise Questions
-- Which id value has the most duplicate records in the user logs table
SELECT 
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS count_dups
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
ORDER BY count_dups DESC
LIMIT 1;


-- Which log_date value had the most duplicate records after removing the max duplicates id value from the previous question
WITH log_date_dups AS (
SELECT 
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic,
  COUNT(*) AS count_dups
FROM health.user_logs
GROUP BY
  id,
  log_date,
  measure,
  measure_value,
  systolic,
  diastolic
)
SELECT log_date, SUM(count_dups) AS sum_dups FROM log_date_dups
WHERE id NOT IN ('054250c692e07a9fa9e62e345231df4b54ff435d')
GROUP BY log_date
ORDER BY sum_dups DESC 


SELECT
log_date,
COUNT(*) AS tot_records
FROM health.user_logs
WHERE id NOT IN ('054250c692e07a9fa9e62e345231df4b54ff435d')
GROUP BY log_date
ORDER BY tot_records DESC
