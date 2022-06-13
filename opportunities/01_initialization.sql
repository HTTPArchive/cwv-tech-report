CREATE TEMP FUNCTION IS_INTERESTING(app STRING) RETURNS BOOL AS (
  app IN (
    # JavaScript frameworks and libraries
    'React', 'Next.js', 'Angular', 'Vue.js', 'Nuxt.js', 'Svelte', 'SvelteKit', 'Preact',
    # CMSs 
    'WordPress', 'Drupal', 'Joomla', 'Wix', 'Squarespace', 'Duda', 'Shopify')
);

CREATE TEMP FUNCTION GET_AUDITS(lhr STRING) RETURNS ARRAY<STRUCT<metric STRING, audit STRING, passing BOOL>> AS (
[
STRUCT('FID' AS metric, 'third-party-summary' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."third-party-summary".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'third-party-facades' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."third-party-facades".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'bootup-time' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."bootup-time".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'mainthread-work-breakdown' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."mainthread-work-breakdown".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'dom-size' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."dom-size".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'duplicated-javascript' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."duplicated-javascript".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'legacy-javascript' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."legacy-javascript".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('FID' AS metric, 'viewport' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."viewport".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'server-response-time' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."server-response-time".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'render-blocking-resources' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."render-blocking-resources".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'redirects' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."redirects".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'uses-text-compression' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-text-compression".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'uses-rel-preconnect' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preconnect".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'uses-rel-preload' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preload".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'font-display' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."font-display".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'unminified-javascript' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-javascript".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'unminified-css' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-css".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'unused-css-rules' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-css-rules".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'preload-lcp-image' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."preload-lcp-image".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'unused-javascript' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-javascript".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'efficient-animated-content' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."efficient-animated-content".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'total-byte-weight' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."total-byte-weight".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'uses-optimized-images' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-optimized-images".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'uses-responsive-images' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-responsive-images".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('LCP' AS metric, 'modern-image-formats' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."modern-image-formats".score') AS FLOAT64) >= 0.9 AS passing),
STRUCT('CLS' AS metric, 'unsized-images' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unsized-images".score') AS FLOAT64) >= 0.9 AS passing)
]
);

CREATE TEMP FUNCTION GET_PCT_GOOD_LCP(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.largest_contentful_paint.percentiles.p75') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_PCT_GOOD_CLS(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.cumulative_layout_shift.percentiles.p75') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_PCT_GOOD_FID(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.first_input_delay.percentiles.p75') AS NUMERIC)
);

CREATE TEMP FUNCTION GET_LAB_LCP(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$."_chromeUserTiming.LargestContentfulPaint"') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_LAB_CLS(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$."_chromeUserTiming.CumulativeLayoutShift"') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_LAB_TBT(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$."_TotalBlockingTime"') AS NUMERIC)
);

CREATE TEMP FUNCTION GET_CWV(har STRING) RETURNS ARRAY<STRUCT<env STRING, metric STRING, value NUMERIC>> AS (
  [
    STRUCT('field' AS env, 'LCP' AS metric, GET_PCT_GOOD_LCP(har) AS value),
    STRUCT('field' AS env, 'FID' AS metric, GET_PCT_GOOD_FID(har) AS value),
    STRUCT('field' AS env, 'CLS' AS metric, GET_PCT_GOOD_CLS(har) AS value),
    STRUCT('lab' AS env, 'LCP' AS metric, GET_LAB_LCP(har) AS value),
    STRUCT('lab' AS env, 'FID' AS metric, GET_LAB_TBT(har) AS value),
    STRUCT('lab' AS env, 'CLS' AS metric, GET_LAB_CLS(har) AS value)
  ]
);

CREATE TEMP FUNCTION CALC_PCT_DIFF(before NUMERIC, after NUMERIC) RETURNS NUMERIC AS (
  SAFE_DIVIDE(after - before, before)
);

WITH technologies AS (
  SELECT DISTINCT
    url,
    app AS technology
  FROM
    `httparchive.technologies.2022_02_01_mobile`
  WHERE
    IS_INTERESTING(app)
), audits AS (
  SELECT
    url,
    metric,
    audit,
    after.passing AS improved
  FROM (
    SELECT
      url,
      audit.*
    FROM
      `httparchive.lighthouse.2021_04_01_mobile`,
      UNNEST(GET_AUDITS(report)) AS audit
    UNION ALL
    SELECT
      url,
      audit.*
    FROM
      `httparchive.lighthouse.2021_06_01_mobile`,
      UNNEST([
        STRUCT('LCP' AS metric, 'modern-image-formats' AS audit, SAFE_CAST(JSON_VALUE(report, '$.audits."modern-image-formats".score') AS FLOAT64) >= 0.9 AS passing)
      ]) AS audit) AS before
  JOIN (
    SELECT
      url,
      audit.*
    FROM
      `httparchive.lighthouse.2022_02_01_mobile`,
      UNNEST(GET_AUDITS(report)) AS audit) AS after
  USING
    (url, metric, audit)
  WHERE
    before.passing != after.passing AND
    before.passing IS NOT NULL AND
    after.passing IS NOT NULL
), cwv AS (
SELECT
  url,
  env,
  metric,
  before.value AS before,
  after.value AS after,
  CALC_PCT_DIFF(before.value, after.value) AS pct_diff
FROM (
  SELECT
    url,
    env,
    metric,
    value
  FROM
    `httparchive.pages.2021_04_01_mobile`,
    UNNEST(GET_CWV(payload))) AS before
JOIN (
  SELECT
    url,
    env,
    metric,
    value
  FROM
    `httparchive.pages.2022_02_01_mobile`,
    UNNEST(GET_CWV(payload))) AS after
USING
  (url, env, metric)
)

SELECT
  *
FROM
  technologies
JOIN
  audits
USING
  (url)
JOIN
  cwv
USING
  (url, metric)
WHERE
  pct_diff IS NOT NULL
