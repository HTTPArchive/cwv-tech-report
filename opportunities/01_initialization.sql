CREATE OR REPLACE TABLE `httparchive.core_web_vitals.lighthouse` AS
SELECT
  *
FROM (
  SELECT DISTINCT
    url,
    app AS technology
  FROM
    `httparchive.technologies.2022_06_01_mobile`
  UNION ALL
  SELECT
    url,
    'ALL' AS technology
  FROM
    `httparchive.summary_pages.2022_06_01_mobile`)
JOIN (
  SELECT
    url,
    metric,
    audit,
    after.passing AS improved
  FROM (
    SELECT
      url,
      audit.*,
      audit.score >= 0.9 AS passing
    FROM
      `httparchive.lighthouse.2021_06_01_mobile`,
      UNNEST(httparchive.core_web_vitals.GET_AUDITS(report)) AS audit) AS before
  JOIN (
    SELECT
      url,
      audit.*,
      audit.score >= 0.9 AS passing
    FROM
      `httparchive.lighthouse.2022_06_01_mobile`,
      UNNEST(httparchive.core_web_vitals.GET_AUDITS(report)) AS audit) AS after
  USING
    (url, metric, audit)
  WHERE
    before.passing != after.passing AND
    before.passing IS NOT NULL AND
    after.passing IS NOT NULL)
USING
  (url)
JOIN (
  SELECT
    url,
    env,
    metric,
    before.value AS before,
    after.value AS after,
    httparchive.core_web_vitals.CALC_PCT_DIFF(before.value, after.value) AS pct_diff
  FROM (
    SELECT
      url,
      env,
      metric,
      value
    FROM
      `httparchive.pages.2021_06_01_mobile`,
      UNNEST(httparchive.core_web_vitals.GET_CWV(payload))) AS before
  JOIN (
    SELECT
      url,
      env,
      metric,
      value
    FROM
      `httparchive.pages.2022_06_01_mobile`,
      UNNEST(httparchive.core_web_vitals.GET_CWV(payload))) AS after
  USING
    (url, env, metric))
USING
  (url, metric)
WHERE
  pct_diff IS NOT NULL
