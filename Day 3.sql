WITH sample_data (example_values) AS (
VALUES
(82),(51),(114),(84),(120),(148),(148),(108),(160),(86)
)
SELECT
  ROUND(VARIANCE(example_values),2) AS varience_value,
  ROUND(STDDEV(example_values),2) AS standard_deviation_value,
  ROUND(AVG(example_values),2) AS mean_value,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY example_values) AS median_value,
  MODE() within group (ORDER BY example_values) AS mode_value
FROM sample_data;

-- Calculate the following on measure_value only for weight
-- Min, Max, Avg, starard deviation, variance
WITH statistics_analysis AS (
SELECT
  MIN(measure_value) AS min_value,
  MAX(measure_value) AS max_value,
  AVG(measure_value) AS avg_value,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY measure_value) AS median_weight,
  MODE() WITHIN GROUP (ORDER BY measure_value) AS mode_value,
  VARIANCE(measure_value) AS variance_value,
  STDDEV(measure_value) AS std_dev_value
  FROM health.user_logs
WHERE measure='weight'
AND measure_value BETWEEN 1 AND 201
)
SELECT *, max_value - min_value AS range_value
FROM statistics_analysis;

