// This script assumes that there exists a `lhr` object containing a Lighthouse Report.
// It generates the SQL needed to extract the before/after status for each audit, used by 01_initialization.sql.

Object.values(lhr.categories).flatMap(category => {
    return category.auditRefs.flatMap(ref => {
        let auditIds = [ref.id];
        if (('relevantAudits' in ref)) {
            auditIds = ref.relevantAudits;
        }

        return auditIds.map(auditId => {
            const audit = lhr.audits[auditId];
            const {id, score, scoreDisplayMode} = audit;
            return {
                id,
                score,
                scoreDisplayMode,
                category: category.id,
                group: ref.group,
                metric: ref.acronym,
                weight: ref.weight
            };
        });
    });
}).filter(a => {
    return a.scoreDisplayMode != 'informative' && a.scoreDisplayMode != 'manual';
}).map(a => {
    const nullify = value => value ? `'${value}'` : 'NULL';
    return `  STRUCT(${nullify(a.metric)} AS metric, '${a.id}' AS audit, '${a.category}' AS category, ${nullify(a.group)} AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."${a.id}".score') AS FLOAT64) AS score)`;
}).join(',\n');
