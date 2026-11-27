
# GeoPulse – Week 1 Environment Readiness Checklist

## 1. Purpose

This checklist tracks the technical environment and dependencies required to begin the GeoPulse data processing and spatial analysis workflow.

It helps identify completed setup activities, pending installations, blockers and prerequisites before moving into implementation.

## 2. Project Technology Stack

| Technology | Purpose | Responsible Workstream |
|---|---|---|
| Python | GPS data generation and processing | Data Generation |
| Excel | Data cleaning and validation | Data Preparation |
| MySQL | Database storage and SQL analysis | SQL Analytics |
| PostgreSQL | Database environment | Spatial Integration |
| PostGIS | Geospatial data processing | Spatial Integration |
| Kepler.gl | Geographic visualization | Spatial Integration |
| Power BI | Business dashboards | Spatial Integration |
| Apache Airflow | Workflow automation | Spatial Integration |

## 3. Environment Readiness

| Component | Current Status | Next Action |
|---|---|---|
| GitHub repository | Available | Continue branch-based development |
| PostgreSQL | Installed | Verify database connectivity |
| GeoPulse database | Created | Verify database configuration |
| PostGIS | Pending | Complete installation and enable extension |
| pgAdmin | Pending setup | Complete installation and connection configuration |
| Python environment | Setup initiated | Verify required packages |
| GPS dataset | Pending | Receive generated dataset |
| MySQL environment | Workstream dependent | Confirm setup and data import |
| Excel preparation | Pending dataset | Prepare and validate source data |
| Kepler.gl | Not yet implemented | Begin after spatial outputs are available |
| Power BI | Not yet implemented | Begin after validated analysis results |
| Airflow | Not yet implemented | Plan automation after pipeline is established |

## 4. Week 1 Prerequisites

Before proceeding to spatial analysis, the following prerequisites should be completed:

- [ ] GPS dataset generated with 5,000 simulated records.
- [ ] Dataset contains DeviceID, Latitude, Longitude and Timestamp.
- [ ] Dataset generation validation completed.
- [ ] Excel data preparation completed.
- [ ] MySQL database and tables prepared.
- [ ] SQL data validation executed.
- [ ] PostgreSQL connection verified.
- [ ] PostGIS extension installed and enabled.
- [ ] Study area and store locations documented.
- [ ] Dataset schema confirmed across all workstreams.

## 5. PostGIS Verification

After PostGIS installation, execute the following query to confirm extension availability:

```sql
SELECT PostGIS_Version();
```

If the extension has not been enabled in the GeoPulse database, execute:

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

Then verify spatial functionality:

```sql
SELECT
    ST_AsText(
        ST_SetSRID(
            ST_MakePoint(78.3915, 17.4483),
            4326
        )
    ) AS sample_location;
```

The coordinates above are illustrative only and are not confirmed store locations.

## 6. Integration Dependencies

The project follows this dependency sequence:

1. Python generates simulated GPS observations.
2. Excel validates and prepares the dataset.
3. MySQL stores and analyses the prepared records.
4. PostGIS performs spatial analysis.
5. Kepler.gl visualizes geographical patterns.
6. Power BI presents business insights.
7. Apache Airflow automates the completed workflow.

Each stage should use validated outputs from the previous stage.

## 7. Current Blockers

- GPS dataset delivery is required before end-to-end testing.
- PostGIS installation must be completed before spatial queries can be executed.
- Store locations and geographical boundaries must be confirmed.
- Database schema consistency must be maintained across team members.
- Actual validation results must be documented before reporting completion.

## 8. Readiness Principle

A component should be marked completed only after its functionality has been tested and verified.

Installation, configuration, testing and implementation should be tracked as separate activities.

This checklist represents the Week 1 readiness status and will be updated as project dependencies are completed.