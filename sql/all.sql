CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

CREATE TEMP FUNCTION GET_LIGHTHOUSE_CATEGORY_SCORES(categories STRING)
RETURNS STRUCT<accessibility NUMERIC, best_practices NUMERIC, performance NUMERIC, pwa NUMERIC, seo NUMERIC> 
LANGUAGE js AS '''
try {
  const $ = JSON.parse(categories);
  return {
    accessibility: $.accessibility.score,
    'best-practices': $['best-practices'].score,
    performance: $.performance.score,
    pwa: $.pwa.score,
    seo: $.seo.score
  };
} catch (e) {
  return {};
}
''';

WITH unique_categories AS (
  SELECT
    ARRAY_AGG(DISTINCT LOWER(category)) AS categories
  FROM
    `httparchive.technologies.2021_09_01_mobile`
), geo_summary AS (
  SELECT
    CAST(REGEXP_REPLACE(CAST(yyyymm AS STRING), r'(\d{4})(\d{2})', r'\1-\2-01') AS DATE) AS date,
    * EXCEPT (country_code),
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo
  FROM
    `chrome-ux-report.materialized.country_summary`
UNION ALL
  SELECT
    * EXCEPT (yyyymmdd, p75_fid_origin, p75_cls_origin, p75_lcp_origin),
    'ALL' AS geo
  FROM
    `chrome-ux-report.materialized.device_summary`
), crux AS (
  SELECT
    date,
    geo,
    CONCAT(origin, '/') AS url,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    
    # CWV
    IS_NON_ZERO(fast_fid, avg_fid, slow_fid) AS any_fid,
    IS_GOOD(fast_fid, avg_fid, slow_fid) AS good_fid,
    IS_NON_ZERO(small_cls, medium_cls, large_cls) AS any_cls,
    IS_GOOD(small_cls, medium_cls, large_cls) AS good_cls,
    IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AS any_lcp,
    IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AS good_lcp,
    (IS_GOOD(fast_fid, avg_fid, slow_fid) OR fast_fid IS NULL) AND
    IS_GOOD(small_cls, medium_cls, large_cls) AND
    IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AS good_cwv,
    
    # WV
    IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp) AS any_fcp,
    IS_GOOD(fast_fcp, avg_fcp, slow_fcp) AS good_fcp,
    IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb) AS any_ttfb,
    IS_GOOD(fast_ttfb, avg_ttfb, slow_ttfb) AS good_ttfb
  FROM
    geo_summary
  WHERE
    date >= '2020-01-01' AND
    device IN ('desktop', 'phone')
), technologies AS (
  SELECT DISTINCT
    CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d)_(\d{2})_(\d{2}).*', r'202\1-\2-\3') AS DATE) AS date,
    IF(category != '' AND LOWER(category) IN UNNEST((SELECT categories FROM unique_categories)), category, NULL) AS category,
    app,
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    url
  FROM
    `httparchive.technologies.202*`
  WHERE
    app IS NOT NULL AND
    app != ''
), summary_stats AS (
  SELECT
    CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d)_(\d{2})_(\d{2}).*', r'202\1-\2-\3') AS DATE) AS date,
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    url,
    bytesTotal,
    bytesJS,
    bytesImg
  FROM
    `httparchive.summary_pages.202*`
), lighthouse AS (
  SELECT
    CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d)_(\d{2})_(\d{2}).*', r'202\1-\2-\3') AS DATE) AS date,
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    url,
    GET_LIGHTHOUSE_CATEGORY_SCORES(JSON_QUERY(report, '$.categories')) AS lighthouse_category
  FROM
    `httparchive.lighthouse.202*`
)


SELECT
  date,
  geo,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT category IGNORE NULLS ORDER BY category), ', ') AS categories,
  app,
  client,
  COUNT(DISTINCT url) AS origins,
  
  # CrUX data
  COUNT(DISTINCT IF(good_fid, url, NULL)) AS origins_with_good_fid,
  COUNT(DISTINCT IF(good_cls, url, NULL)) AS origins_with_good_cls,
  COUNT(DISTINCT IF(good_lcp, url, NULL)) AS origins_with_good_lcp,
  COUNT(DISTINCT IF(good_fcp, url, NULL)) AS origins_with_good_fcp,
  COUNT(DISTINCT IF(good_ttfb, url, NULL)) AS origins_with_good_ttfb,
  COUNT(DISTINCT IF(any_fid, url, NULL)) AS origins_with_any_fid,
  COUNT(DISTINCT IF(any_cls, url, NULL)) AS origins_with_any_cls,
  COUNT(DISTINCT IF(any_lcp, url, NULL)) AS origins_with_any_lcp,
  COUNT(DISTINCT IF(any_fcp, url, NULL)) AS origins_with_any_fcp,
  COUNT(DISTINCT IF(any_ttfb, url, NULL)) AS origins_with_any_ttfb,
  COUNT(DISTINCT IF(good_cwv, url, NULL)) AS origins_with_good_cwv,
  COUNT(DISTINCT IF(any_lcp AND any_cls, url, NULL)) AS origins_eligible_for_cwv,
  SAFE_DIVIDE(COUNTIF(good_cwv), COUNTIF(any_lcp AND any_cls)) AS pct_eligible_origins_with_good_cwv,
  
  # Lighthouse data
  APPROX_QUANTILES(lighthouse_category.accessibility, 1000)[OFFSET(500)] AS median_lighthouse_score_accessibility,
  APPROX_QUANTILES(lighthouse_category.best_practices, 1000)[OFFSET(500)] AS median_lighthouse_score_best_practices,
  APPROX_QUANTILES(lighthouse_category.performance, 1000)[OFFSET(500)] AS median_lighthouse_score_performance,
  APPROX_QUANTILES(lighthouse_category.pwa, 1000)[OFFSET(500)] AS median_lighthouse_score_pwa,
  APPROX_QUANTILES(lighthouse_category.seo, 1000)[OFFSET(500)] AS median_lighthouse_score_seo,
  
  # Page weight stats
  APPROX_QUANTILES(bytesTotal, 1000)[OFFSET(500)] AS median_bytes_total,
  APPROX_QUANTILES(bytesJS, 1000)[OFFSET(500)] AS median_bytes_js,
  APPROX_QUANTILES(bytesImg, 1000)[OFFSET(500)] AS median_bytes_image
  
FROM
  technologies
JOIN
  summary_stats
USING
  (date, client, url)
LEFT JOIN
  lighthouse
USING
  (date, client, url)
JOIN
  crux
USING
  (date, client, url)
GROUP BY
  date,
  geo,
  app,
  client
