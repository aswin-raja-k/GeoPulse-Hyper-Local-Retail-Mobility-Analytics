
# GeoPulse – PostGIS Spatial Analysis Plan

## 1. Purpose

Prepare GeoPulse GPS records for spatial analysis to measure retail footfall, store catchment areas, and movement around store locations.

**Status:** Planning document only. PostGIS installation and spatial queries have not yet been completed.

## 2. Expected Input Data

The prepared GPS dataset is expected to contain:

| Field | Description |
|---|---|
| DeviceID | An anonymized device identifier |
| Latitude | GPS latitude in decimal degrees |
| Longitude | GPS longitude in decimal degrees |
| Timestamp | Date and time of the GPS observation |

Store location data will also be required, including a unique store identifier and latitude/longitude coordinates.

The final study area and store coordinates are yet to be confirmed.

## 3. Planned Database Preparation

The following steps will be performed after PostGIS installation:

1. Verify that latitude and longitude values are numeric and within valid ranges.
2. Confirm the coordinate reference system used by the source data.
3. Enable the PostGIS extension.
4. Convert GPS coordinates into spatial point geometries.
5. Create a spatial index to improve location-based query performance.

### Example PostGIS Setup SQL

```sql
CREATE EXTENSION IF NOT EXISTS postgis;

ALTER TABLE gps_points
ADD COLUMN location geometry(Point, 4326);

UPDATE gps_points
SET location = ST_SetSRID(
    ST_MakePoint(longitude, latitude),
    4326
)
WHERE longitude BETWEEN -180 AND 180
  AND latitude BETWEEN -90 AND 90;

CREATE INDEX gps_points_location_gix
ON gps_points
USING GIST (location);
```

*Note: This is an example. Table and column names must be adjusted to match the final database schema.*

## 4. Planned Spatial Analysis

### 4.1 Store Proximity Analysis
Identify GPS observations located within a configurable distance of each retail store.

### 4.2 Store Catchment Analysis
Estimate the number of distinct anonymized devices around each store.

### 4.3 Hourly Footfall Analysis
Group nearby GPS observations by hour to understand changes in store-area activity.

### 4.4 Store Catchment Overlap
Compare nearby store catchment areas to identify potential overlap in customer movement.

### Example Store Proximity Query

```sql
SELECT
    s.store_id,
    COUNT(DISTINCT g.deviceid) AS nearby_devices
FROM stores AS s
JOIN gps_points AS g
    ON ST_DWithin(
        g.location::geography,
        s.location::geography,
        500
    )
GROUP BY s.store_id;
```

*Note: The 500-metre distance is illustrative and must be agreed upon before actual analysis.*

## 5. Data Validation and Quality Checks

Before performing spatial analysis, the following checks will be considered:

- Identify missing latitude and longitude values.
- Detect invalid coordinate ranges.
- Verify that spatial geometries are created successfully.
- Confirm the expected SRID (4326).
- Check spatial index availability.
- Validate the selected store proximity distance.
- Ensure that only simulated or anonymized GPS data is used.

## 6. Dependencies and Next Steps

1. Complete PostGIS installation and enable the extension.
2. Receive the validated GPS dataset from the data preparation and Python workstreams.
3. Confirm the study area and store coordinates.
4. Finalize the catchment distance and analysis methodology.
5. Execute spatial queries and validate their outputs.
6. Document actual findings with supporting evidence.
7. Prepare verified spatial outputs for Kepler.gl visualization and Power BI dashboards.

## 7. Current Implementation Status

| Component | Status |
|---|---|
| PostgreSQL installation | Completed |
| GeoPulse database creation | Completed |
| PostGIS installation | Pending |
| Spatial table preparation | Pending |
| GPS geometry generation | Pending |
| Spatial index creation | Pending |
| Store proximity analysis | Planned |
| Catchment analysis | Planned |
| Kepler.gl integration | Planned |

## 8. Documentation Note

This document describes the planned PostGIS implementation and analysis workflow.

No spatial analysis results, footfall totals, catchment measurements, or business conclusions are claimed at this stage.

All future findings will be documented only after successful execution, validation, and review.
