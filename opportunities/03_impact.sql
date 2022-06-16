CREATE OR REPLACE TABLE `httparchive.core_web_vitals.lighthouse_impact` AS
SELECT
  technology,
  metric,
  audit,
  env,
  passed.pages + failed.pages AS pages,
  passed.pct_diff - failed.pct_diff AS estimated_passing_impact_pct
FROM (
  SELECT
    technology,
    metric,
    audit,
    env,
    pages,
    pct_diff
  FROM
    `httparchive.core_web_vitals.lighthouse_stats`
  WHERE
    percentile = 50 AND
    NOT improved) AS failed
JOIN (
  SELECT
    technology,
    metric,
    audit,
    env,
    pages,
    pct_diff
  FROM
    `httparchive.core_web_vitals.lighthouse_stats`
  WHERE
    percentile = 50 AND
    improved) AS passed
USING
  (technology, metric, audit, env)
ORDER BY
  pages DESC
