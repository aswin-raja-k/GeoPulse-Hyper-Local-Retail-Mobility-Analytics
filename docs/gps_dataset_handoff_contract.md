
# GeoPulse – GPS Dataset Handoff Contract

## 1. Purpose

This document defines the agreed minimum dataset structure and handoff checks for the GeoPulse Week 1 workflow.

It keeps Python generation, Excel preparation, MySQL analysis and PostGIS integration aligned.

## 2. Confirmed Dataset Scope

| Item | Agreed Value |
|---|---|
| Study Area | Madhapur, Hyderabad, India |
| Dataset Size | 5,000 simulated GPS records |
| Data Type | Simulated and anonymized location observations |
| Required Fields | DeviceID, Latitude, Longitude, Timestamp |

The final geographical boundary and detailed generation pattern still need to be documented by the team.

## 3. Required CSV Structure

| Column | Meaning | Expectation |
|---|---|---|
| DeviceID | An anonymized device identifier | No real personal identifiers |
| Latitude | Latitude coordinate | Numeric and valid |
| Longitude | Longitude coordinate | Numeric and valid |
| Timestamp | Date and time of observation | Consistently formatted and parseable |

Recommended CSV header:

```csv
DeviceID,Latitude,Longitude,Timestamp
```

Do not add extra columns to the initial handoff without informing the other workstreams.

## 4. Generation-to-Analysis Handoff

1. Python generation: create 5,000 simulated records for the agreed study area.
2. Initial validation: check record count, required columns, missing values, coordinate validity and timestamp parsing.
3. Excel preparation: review the raw file, document cleaning and preserve an unchanged copy of the original data.
4. MySQL analysis: import the prepared dataset using the agreed column names and data types.
5. PostGIS integration: construct spatial points using longitude as X and latitude as Y.
6. Visualization: pass only validated outputs to Kepler.gl and Power BI.

## 5. Minimum Acceptance Checks

Before the dataset is marked ready for handoff, verify:

- Exactly 5,000 data records, excluding the header.
- All four required columns are present.
- DeviceID values are populated and anonymized.
- Latitude and Longitude are numeric and within valid global ranges.
- No required coordinate values are missing.
- Timestamp values can be parsed consistently.
- Generated locations correspond to the agreed Madhapur study area.
- Raw generated data is preserved separately from cleaned data.
- Validation results and rejected or corrected records are documented.

A check must be reported as pending if it has not actually been performed.

## 6. Decisions Still to Be Recorded

- Exact study-area boundary or bounding coordinates.
- Number of unique DeviceID values.
- GPS observation period and sampling interval.
- Timestamp timezone and exact storage format.
- Store locations and store identifier structure.
- Final shared file location and naming convention.

## 7. Handoff Evidence

The generating workstream should provide:

- Generated CSV file.
- Python generation script.
- Short validation summary.
- Notes describing assumptions and limitations.

The preparation and SQL workstreams should report schema changes before using them downstream.

## 8. Data Integrity Rule

Use only simulated or anonymized data.

Keep raw and prepared datasets distinguishable.

Record actual validation results and implementation status. Do not invent completed work, measurements or business findings.

**Document Status:** Week 1 handoff contract.

This document defines expectations; it does not claim that the dataset has already been generated, validated or imported.
