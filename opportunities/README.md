# CWV opportunities

The purpose of this project is to supplement the CWV Technology Report with a dashboard to assess the opportunities for each technology.

- Stage 1 initializes the data for the particular technologies/audits of interest
  - lighthouse_cwv.js generates the corresponding SQL for the audit map
- Stage 2 aggregates the results from Stage 1 into discrete percentiles
- Stage 3 calculates the estimated impact from the medians in Stage 2
- Stage 4 calculates the remaining opportunity based on audit failure rates
