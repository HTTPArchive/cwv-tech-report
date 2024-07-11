CREATE OR REPLACE TABLE httparchive.core_web_vitals.lighthouse_opportunities AS

WITH audits_with_impact AS (
  SELECT DISTINCT
    technology,
    audit
  FROM
    `httparchive.core_web_vitals.lighthouse_stats`
), technologies AS (
  SELECT DISTINCT
    url,
    app AS technology,
    COUNT(DISTINCT url) OVER (PARTITION BY app) AS total
  FROM
    `httparchive.technologies.2022_06_01_mobile`
  UNION ALL
  SELECT
    url,
    'ALL' AS technology,
    COUNT(0) OVER () AS total
  FROM
    `httparchive.summary_pages.2022_06_01_mobile`
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
    `httparchive.summary_pages.2022_06_01_mobile`
  UNION ALL
  SELECT
    url,
    'ALL' AS rank
  FROM
    `httparchive.summary_pages.2022_06_01_mobile`
), failing_audits AS (
  SELECT
    audit.audit,
    url
  FROM
    `httparchive.lighthouse.2022_06_01_mobile`,
    UNNEST(httparchive.core_web_vitals.GET_AUDITS(report)) AS audit
  WHERE
    score < 0.9
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
