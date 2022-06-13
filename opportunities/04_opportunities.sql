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

WITH audits_with_impact AS (
  SELECT DISTINCT
    technology,
    audit
  FROM
    `httparchive.scratchspace.lh_cwv_stats`
), technologies AS (
  SELECT DISTINCT
    url,
    app AS technology,
    COUNT(DISTINCT url) OVER (PARTITION BY app) AS total
  FROM
    `httparchive.technologies.2022_02_01_mobile`
  WHERE
    IS_INTERESTING(app)
), ranks AS (
  SELECT
    url,
    CASE rank
      WHEN 1000 THEN 'head'
      WHEN 10000 THEN 'torso'
      WHEN 100000 THEN 'torso'
      WHEN 1000000 THEN 'torso'
      ELSE 'tail'
    END AS rank
  FROM
    `httparchive.summary_pages.2022_02_01_mobile`
), failing_audits AS (
  SELECT
    audit.audit,
    url
  FROM
    `httparchive.lighthouse.2022_02_01_mobile`,
    UNNEST(GET_AUDITS(report)) AS audit
  WHERE
    NOT passing
), totals_per_rank_technology AS (
  SELECT
    technology,
    rank,
    COUNT(DISTINCT url) AS total_per_rank
  FROM
    ranks
  JOIN
    technologies
  USING
    (url)
  GROUP BY
    technology,
    rank
)

SELECT
  technology,
  audit,
  rank,
  COUNT(0) AS failing,
  ANY_VALUE(total) AS total_technology,
  COUNT(0) / ANY_VALUE(total) AS pct_failing_technology,
  ANY_VALUE(total_per_rank) AS total_per_rank,
  COUNT(0) / ANY_VALUE(total_per_rank) AS pct_failing_per_technology_rank
FROM
  audits_with_impact
JOIN
  technologies
USING
  (technology)
JOIN
  failing_audits
USING
  (audit, url)
JOIN
  ranks
USING
  (url)
JOIN
  totals_per_rank_technology
USING
  (technology, rank)
GROUP BY
  technology,
  audit,
  rank
ORDER BY
  total_technology DESC
