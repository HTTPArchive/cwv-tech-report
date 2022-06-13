// This script assumes that there exists a `lhr` object containing a Lighthouse Report.
// It generates the SQL needed to extract the before/after status for each audit, used by 01_initialization.sql.

lhr.categories.performance.auditRefs.filter(ar => {
  return ['TBT', 'LCP', 'CLS'].includes(ar.acronym);
}).map(ar => {
  return [ar.acronym, ar.relevantAudits];
}).map(([metric, ras]) => {
  return [
    metric,
    ras.map(ra => {
      return lhr.audits[ra];
    }).filter(a => {
      return a.scoreDisplayMode != 'informative';
    })
  ];
}).flatMap(([metric, audits]) => {
  return audits.map(a => {
    return `STRUCT('${metric == 'TBT' ? 'FID' : metric}' AS metric, '${a.id}' AS audit, SAFE_CAST(JSON_VALUE(lhr, '$.audits."${a.id}".score') AS FLOAT64) >= 0.9 AS passing)`;
  });
}).join(',\n');
