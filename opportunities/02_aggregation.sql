CREATE OR REPLACE TABLE `httparchive.core_web_vitals.lighthouse_stats` AS
SELECT
  percentile,
  technology,
  metric,
  audit,
  env,
  improved,
  COUNT(0) AS pages,
  APPROX_QUANTILES(pct_diff, 1000)[OFFSET(percentile * 10)] AS pct_diff
FROM
  `httparchive.core_web_vitals.lighthouse`,
  UNNEST(GENERATE_ARRAY(1, 100, 1)) AS percentile
GROUP BY
  percentile,
  technology,
  metric,
  audit,
  env,
  improved
