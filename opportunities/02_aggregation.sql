CREATE OR REPLACE TABLE `httparchive.scratchspace.lh_cwv_stats` AS
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
  `httparchive.scratchspace.lh_cwv`,
  UNNEST(GENERATE_ARRAY(1, 100, 1)) AS percentile
GROUP BY
  percentile,
  technology,
  metric,
  audit,
  env,
  improved
