# Note: you'll need to manually configure this query in the BigQuery UI to overwrite the contents of the `httparchive.scratchspace.lh_cwv` table.

# This content is generated from lighthouse_cwv.js.
CREATE TEMP FUNCTION GET_AUDITS(lhr STRING) RETURNS ARRAY<STRUCT<metric STRING, audit STRING, category STRING, audit_group STRING, score FLOAT64>> AS (
[
  STRUCT('FCP' AS metric, 'server-response-time' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."server-response-time".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'render-blocking-resources' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."render-blocking-resources".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'redirects' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."redirects".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'uses-text-compression' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-text-compression".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'uses-rel-preconnect' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preconnect".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'uses-rel-preload' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preload".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'font-display' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."font-display".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'unminified-javascript' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-javascript".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'unminified-css' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-css".score') AS FLOAT64) AS score),
  STRUCT('FCP' AS metric, 'unused-css-rules' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-css-rules".score') AS FLOAT64) AS score),
  STRUCT('TTI' AS metric, 'interactive' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."interactive".score') AS FLOAT64) AS score),
  STRUCT('SI' AS metric, 'speed-index' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."speed-index".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'third-party-summary' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."third-party-summary".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'third-party-facades' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."third-party-facades".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'bootup-time' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."bootup-time".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'mainthread-work-breakdown' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."mainthread-work-breakdown".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'dom-size' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."dom-size".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'duplicated-javascript' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."duplicated-javascript".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'legacy-javascript' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."legacy-javascript".score') AS FLOAT64) AS score),
  STRUCT('TBT' AS metric, 'viewport' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."viewport".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'server-response-time' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."server-response-time".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'render-blocking-resources' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."render-blocking-resources".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'redirects' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."redirects".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'uses-text-compression' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-text-compression".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'uses-rel-preconnect' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preconnect".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'uses-rel-preload' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preload".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'font-display' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."font-display".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'unminified-javascript' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-javascript".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'unminified-css' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-css".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'unused-css-rules' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-css-rules".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'preload-lcp-image' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."preload-lcp-image".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'unused-javascript' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-javascript".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'efficient-animated-content' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."efficient-animated-content".score') AS FLOAT64) AS score),
  STRUCT('LCP' AS metric, 'total-byte-weight' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."total-byte-weight".score') AS FLOAT64) AS score),
  STRUCT('CLS' AS metric, 'unsized-images' AS audit, 'performance' AS category, 'metrics' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unsized-images".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'max-potential-fid' AS audit, 'performance' AS category, 'hidden' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."max-potential-fid".score') AS FLOAT64) AS score),
  STRUCT('FMP' AS metric, 'first-meaningful-paint' AS audit, 'performance' AS category, 'hidden' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."first-meaningful-paint".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'render-blocking-resources' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."render-blocking-resources".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-responsive-images' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-responsive-images".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'offscreen-images' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."offscreen-images".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'unminified-css' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-css".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'unminified-javascript' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unminified-javascript".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'unused-css-rules' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-css-rules".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'unused-javascript' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unused-javascript".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-optimized-images' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-optimized-images".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'modern-image-formats' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."modern-image-formats".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-text-compression' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-text-compression".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-rel-preconnect' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preconnect".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'server-response-time' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."server-response-time".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'redirects' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."redirects".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-rel-preload' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-rel-preload".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-http2' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-http2".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'efficient-animated-content' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."efficient-animated-content".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'duplicated-javascript' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."duplicated-javascript".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'legacy-javascript' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."legacy-javascript".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'preload-lcp-image' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."preload-lcp-image".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'total-byte-weight' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."total-byte-weight".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-long-cache-ttl' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-long-cache-ttl".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'dom-size' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."dom-size".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'user-timings' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."user-timings".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'bootup-time' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."bootup-time".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'mainthread-work-breakdown' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."mainthread-work-breakdown".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'font-display' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."font-display".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'third-party-summary' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."third-party-summary".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'third-party-facades' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."third-party-facades".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'lcp-lazy-loaded' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."lcp-lazy-loaded".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'uses-passive-event-listeners' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."uses-passive-event-listeners".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'no-document-write' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."no-document-write".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'unsized-images' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."unsized-images".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'viewport' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."viewport".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'no-unload-listeners' AS audit, 'performance' AS category, NULL AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."no-unload-listeners".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'performance-budget' AS audit, 'performance' AS category, 'budgets' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."performance-budget".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'timing-budget' AS audit, 'performance' AS category, 'budgets' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."timing-budget".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'accesskeys' AS audit, 'accessibility' AS category, 'a11y-navigation' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."accesskeys".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-allowed-attr' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-allowed-attr".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-command-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-command-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-hidden-body' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-hidden-body".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-hidden-focus' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-hidden-focus".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-input-field-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-input-field-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-meter-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-meter-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-progressbar-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-progressbar-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-required-attr' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-required-attr".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-required-children' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-required-children".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-required-parent' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-required-parent".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-roles' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-roles".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-toggle-field-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-toggle-field-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-tooltip-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-tooltip-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-treeitem-name' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-treeitem-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-valid-attr-value' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-valid-attr-value".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'aria-valid-attr' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."aria-valid-attr".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'button-name' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."button-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'bypass' AS audit, 'accessibility' AS category, 'a11y-navigation' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."bypass".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'color-contrast' AS audit, 'accessibility' AS category, 'a11y-color-contrast' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."color-contrast".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'definition-list' AS audit, 'accessibility' AS category, 'a11y-tables-lists' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."definition-list".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'dlitem' AS audit, 'accessibility' AS category, 'a11y-tables-lists' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."dlitem".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'document-title' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."document-title".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'duplicate-id-active' AS audit, 'accessibility' AS category, 'a11y-navigation' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."duplicate-id-active".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'duplicate-id-aria' AS audit, 'accessibility' AS category, 'a11y-aria' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."duplicate-id-aria".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'form-field-multiple-labels' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."form-field-multiple-labels".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'frame-title' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."frame-title".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'heading-order' AS audit, 'accessibility' AS category, 'a11y-navigation' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."heading-order".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'html-has-lang' AS audit, 'accessibility' AS category, 'a11y-language' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."html-has-lang".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'html-lang-valid' AS audit, 'accessibility' AS category, 'a11y-language' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."html-lang-valid".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'image-alt' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."image-alt".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'input-image-alt' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."input-image-alt".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'label' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."label".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'link-name' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."link-name".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'list' AS audit, 'accessibility' AS category, 'a11y-tables-lists' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."list".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'listitem' AS audit, 'accessibility' AS category, 'a11y-tables-lists' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."listitem".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'meta-refresh' AS audit, 'accessibility' AS category, 'a11y-best-practices' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."meta-refresh".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'meta-viewport' AS audit, 'accessibility' AS category, 'a11y-best-practices' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."meta-viewport".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'object-alt' AS audit, 'accessibility' AS category, 'a11y-names-labels' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."object-alt".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'tabindex' AS audit, 'accessibility' AS category, 'a11y-navigation' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."tabindex".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'td-headers-attr' AS audit, 'accessibility' AS category, 'a11y-tables-lists' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."td-headers-attr".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'th-has-data-cells' AS audit, 'accessibility' AS category, 'a11y-tables-lists' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."th-has-data-cells".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'valid-lang' AS audit, 'accessibility' AS category, 'a11y-language' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."valid-lang".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'video-caption' AS audit, 'accessibility' AS category, 'a11y-audio-video' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."video-caption".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'is-on-https' AS audit, 'best-practices' AS category, 'best-practices-trust-safety' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."is-on-https".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'geolocation-on-start' AS audit, 'best-practices' AS category, 'best-practices-trust-safety' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."geolocation-on-start".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'notification-on-start' AS audit, 'best-practices' AS category, 'best-practices-trust-safety' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."notification-on-start".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'no-vulnerable-libraries' AS audit, 'best-practices' AS category, 'best-practices-trust-safety' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."no-vulnerable-libraries".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'password-inputs-can-be-pasted-into' AS audit, 'best-practices' AS category, 'best-practices-ux' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."password-inputs-can-be-pasted-into".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'image-aspect-ratio' AS audit, 'best-practices' AS category, 'best-practices-ux' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."image-aspect-ratio".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'image-size-responsive' AS audit, 'best-practices' AS category, 'best-practices-ux' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."image-size-responsive".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'preload-fonts' AS audit, 'best-practices' AS category, 'best-practices-ux' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."preload-fonts".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'doctype' AS audit, 'best-practices' AS category, 'best-practices-browser-compat' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."doctype".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'charset' AS audit, 'best-practices' AS category, 'best-practices-browser-compat' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."charset".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'deprecations' AS audit, 'best-practices' AS category, 'best-practices-general' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."deprecations".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'errors-in-console' AS audit, 'best-practices' AS category, 'best-practices-general' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."errors-in-console".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'valid-source-maps' AS audit, 'best-practices' AS category, 'best-practices-general' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."valid-source-maps".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'inspector-issues' AS audit, 'best-practices' AS category, 'best-practices-general' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."inspector-issues".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'viewport' AS audit, 'seo' AS category, 'seo-mobile' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."viewport".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'document-title' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."document-title".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'meta-description' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."meta-description".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'http-status-code' AS audit, 'seo' AS category, 'seo-crawl' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."http-status-code".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'link-text' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."link-text".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'crawlable-anchors' AS audit, 'seo' AS category, 'seo-crawl' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."crawlable-anchors".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'is-crawlable' AS audit, 'seo' AS category, 'seo-crawl' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."is-crawlable".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'robots-txt' AS audit, 'seo' AS category, 'seo-crawl' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."robots-txt".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'image-alt' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."image-alt".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'hreflang' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."hreflang".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'canonical' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."canonical".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'font-size' AS audit, 'seo' AS category, 'seo-mobile' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."font-size".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'plugins' AS audit, 'seo' AS category, 'seo-content' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."plugins".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'tap-targets' AS audit, 'seo' AS category, 'seo-mobile' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."tap-targets".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'installable-manifest' AS audit, 'pwa' AS category, 'pwa-installable' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."installable-manifest".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'service-worker' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."service-worker".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'splash-screen' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."splash-screen".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'themed-omnibox' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."themed-omnibox".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'content-width' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."content-width".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'viewport' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."viewport".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'apple-touch-icon' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."apple-touch-icon".score') AS FLOAT64) AS score),
  STRUCT(NULL AS metric, 'maskable-icon' AS audit, 'pwa' AS category, 'pwa-optimized' AS audit_group, SAFE_CAST(JSON_VALUE(lhr, '$.audits."maskable-icon".score') AS FLOAT64) AS score)
]
);

CREATE TEMP FUNCTION GET_CRUX_LCP(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.largest_contentful_paint.percentiles.p75') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_CRUX_CLS(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.cumulative_layout_shift.percentiles.p75') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_CRUX_FID(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.first_input_delay.percentiles.p75') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_CRUX_INP(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.experimental_interaction_to_next_paint.percentiles.p75') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_CRUX_TTFB(har STRING) RETURNS NUMERIC AS (
  SAFE_CAST(JSON_VALUE(har, '$._CrUX.metrics.experimental_time_to_first_byte.percentiles.p75') AS NUMERIC)
);

CREATE TEMP FUNCTION GET_LAB_LCP(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$."_chromeUserTiming.LargestContentfulPaint"') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_LAB_CLS(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$."_chromeUserTiming.CumulativeLayoutShift"') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_LAB_TBT(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$._TotalBlockingTime') AS NUMERIC)
);
CREATE TEMP FUNCTION GET_LAB_TTFB(har STRING) RETURNS NUMERIC AS (
  CAST(JSON_VALUE(har, '$._TTFB') AS NUMERIC)
);

CREATE TEMP FUNCTION GET_CWV(har STRING) RETURNS ARRAY<STRUCT<env STRING, metric STRING, value NUMERIC>> AS (
  [
    STRUCT('field' AS env, 'LCP' AS metric, GET_CRUX_LCP(har) AS value),
    STRUCT('field' AS env, 'FID' AS metric, GET_CRUX_FID(har) AS value),
    STRUCT('field' AS env, 'CLS' AS metric, GET_CRUX_CLS(har) AS value),
    STRUCT('field' AS env, 'INP' AS metric, GET_CRUX_INP(har) AS value),
    STRUCT('field' AS env, 'TTFB' AS metric, GET_CRUX_TTFB(har) AS value),
    STRUCT('lab' AS env, 'LCP' AS metric, GET_LAB_LCP(har) AS value),
    STRUCT('lab' AS env, 'FID' AS metric, GET_LAB_TBT(har) AS value),
    STRUCT('lab' AS env, 'CLS' AS metric, GET_LAB_CLS(har) AS value),
    STRUCT('lab' AS env, 'TTFB' AS metric, GET_LAB_TTFB(har) AS value)
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
    `httparchive.technologies.2022_06_01_mobile`
  UNION ALL
  SELECT
    url,
    'ALL' AS technology
  FROM
    `httparchive.summary_pages.2022_06_01_mobile`
), audits AS (
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
      UNNEST(GET_AUDITS(report)) AS audit) AS before
  JOIN (
    SELECT
      url,
      audit.*,
      audit.score >= 0.9 AS passing
    FROM
      `httparchive.lighthouse.2022_06_01_mobile`,
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
    `httparchive.pages.2021_06_01_mobile`,
    UNNEST(GET_CWV(payload))) AS before
JOIN (
  SELECT
    url,
    env,
    metric,
    value
  FROM
    `httparchive.pages.2022_06_01_mobile`,
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