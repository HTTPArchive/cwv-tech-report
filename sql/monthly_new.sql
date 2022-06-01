CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(good, good + needs_improvement + poor) >= 0.75
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

######### BEGIN MONTHLY UPDATES
WITH RELEASE_DATE AS (
  SELECT CAST('2022-05-01' AS DATE)
), TECHNOLOGIES_RELEASE AS (
  SELECT
    _TABLE_SUFFIX,
    *
  FROM
    `httparchive.technologies.2022_05_01_*`
), SUMMARY_PAGES_RELEASE AS (
  SELECT
    _TABLE_SUFFIX,
    *
  FROM
    `httparchive.summary_pages.2022_05_01_*`
), LIGHTHOUSE_RELEASE AS (
  SELECT
    _TABLE_SUFFIX,
    *
  FROM
    `httparchive.lighthouse.2022_05_01_*`
),
######### END MONTHLY UPDATES

geo_summary AS (
  SELECT
    CAST(REGEXP_REPLACE(CAST(yyyymm AS STRING), r'(\d{4})(\d{2})', r'\1-\2-01') AS DATE) AS date,
    * EXCEPT (country_code),
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo
  FROM
    `chrome-ux-report.materialized.country_summary`
UNION ALL
  SELECT
    * EXCEPT (yyyymmdd, p75_fid_origin, p75_cls_origin, p75_lcp_origin, p75_inp_origin),
    'ALL' AS geo
  FROM
    `chrome-ux-report.materialized.device_summary`
), crux AS (
  SELECT
    geo,
    CASE _rank
      WHEN 100000000 THEN 'ALL'
      WHEN 10000000 THEN 'Top 10M'
      WHEN 1000000 THEN 'Top 1M'
      WHEN 100000 THEN 'Top 100k'
      WHEN 10000 THEN 'Top 10k'
      WHEN 1000 THEN 'Top 1k'
    END AS rank,
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
    IS_GOOD(fast_ttfb, avg_ttfb, slow_ttfb) AS good_ttfb,
    IS_NON_ZERO(fast_inp, avg_inp, slow_inp) AS any_inp,
    IS_GOOD(fast_inp, avg_inp, slow_inp) AS good_inp
  FROM
    geo_summary,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS _rank
  WHERE
    date = (SELECT * FROM RELEASE_DATE) AND
    device IN ('desktop', 'phone') AND
    rank <= _rank
), technologies AS (
  SELECT DISTINCT
    app,
    _TABLE_SUFFIX AS client,
    url
  FROM
    TECHNOLOGIES_RELEASE
  WHERE
    app IS NOT NULL AND
    app != ''
UNION ALL
  SELECT
    'ALL' AS app,
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    url
  FROM
    SUMMARY_PAGES_RELEASE
), categories AS (
  SELECT
    app,
    ARRAY_TO_STRING(ARRAY_AGG(DISTINCT category IGNORE NULLS ORDER BY category), ', ') AS category
  FROM
    TECHNOLOGIES_RELEASE
  GROUP BY
    app
UNION ALL
  SELECT
    'ALL' AS app,
    ARRAY_TO_STRING(ARRAY_AGG(DISTINCT category IGNORE NULLS ORDER BY category), ', ') AS category
  FROM
    TECHNOLOGIES_RELEASE
), summary_stats AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    bytesTotal,
    bytesJS,
    bytesImg
  FROM
    SUMMARY_PAGES_RELEASE
), lighthouse AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    GET_LIGHTHOUSE_CATEGORY_SCORES(JSON_QUERY(report, '$.categories')) AS lighthouse_category
  FROM
    LIGHTHOUSE_RELEASE
)


SELECT
  (SELECT * FROM RELEASE_DATE) AS date,
  geo,
  rank,
  ANY_VALUE(category) AS category,
  app,
  client,
  COUNT(0) AS origins,
  
  # CrUX data
  COUNTIF(good_fid) AS origins_with_good_fid,
  COUNTIF(good_cls) AS origins_with_good_cls,
  COUNTIF(good_lcp) AS origins_with_good_lcp,
  COUNTIF(good_fcp) AS origins_with_good_fcp,
  COUNTIF(good_ttfb) AS origins_with_good_ttfb,
  COUNTIF(good_inp) AS origins_with_good_inp,
  COUNTIF(any_fid) AS origins_with_any_fid,
  COUNTIF(any_cls) AS origins_with_any_cls,
  COUNTIF(any_lcp) AS origins_with_any_lcp,
  COUNTIF(any_fcp) AS origins_with_any_fcp,
  COUNTIF(any_ttfb) AS origins_with_any_ttfb,
  COUNTIF(any_inp) AS origins_with_any_inp,
  COUNTIF(good_cwv) AS origins_with_good_cwv,
  COUNTIF(any_lcp AND any_cls) AS origins_eligible_for_cwv,
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
  categories
USING
  (app)
JOIN
  summary_stats
USING
  (client, url)
LEFT JOIN
  lighthouse
USING
  (client, url)
JOIN
  crux
USING
  (client, url)
GROUP BY
  app,
  geo,
  rank,
  client