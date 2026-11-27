/*
============================================================
GeoPulse - PostGIS Spatial Foundation
Project: Hyper-Local Retail & Mobility Analytics
Branch: aswin-project-integration

STATUS:
- PostgreSQL 19 verified running.
- PostGIS 3.7.0 available.
- Extension activation currently blocked by Windows
  Application Control policy.
- SQL below is prepared but not yet executed.

Coordinate convention:
Longitude = X
Latitude  = Y
SRID      = 4326
============================================================
*/


-- ==========================================================
-- 1. ENABLE POSTGIS
-- Run after the Windows DLL blocking issue is resolved
-- ==========================================================

CREATE EXTENSION IF NOT EXISTS postgis;


-- Verify PostGIS installation

SELECT PostGIS_Full_Version();


-- ==========================================================
-- 2. CREATE GPS SPATIAL TABLE
-- ==========================================================

CREATE TABLE IF NOT EXISTS gps_points (
    record_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    device_id VARCHAR(100) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    recorded_at TIMESTAMP NOT NULL,
    geom GEOMETRY(Point, 4326)
);


-- ==========================================================
-- 3. CONVERT GPS COORDINATES INTO GEOMETRY
-- IMPORTANT: Longitude comes first in ST_MakePoint()
-- ==========================================================

UPDATE gps_points
SET geom = ST_SetSRID(
    ST_MakePoint(longitude, latitude),
    4326
)
WHERE geom IS NULL;


-- ==========================================================
-- 4. VERIFY GEOMETRY
-- ==========================================================

SELECT
    record_id,
    device_id,
    latitude,
    longitude,
    ST_AsText(geom) AS spatial_point,
    ST_SRID(geom) AS srid
FROM gps_points
LIMIT 10;


-- ==========================================================
-- 5. CREATE SPATIAL INDEX
-- ==========================================================

CREATE INDEX IF NOT EXISTS idx_gps_points_geom
ON gps_points
USING GIST (geom);


-- ==========================================================
-- 6. CREATE DEVICE INDEX
-- ==========================================================

CREATE INDEX IF NOT EXISTS idx_gps_points_device_id
ON gps_points (device_id);


-- ==========================================================
-- 7. CREATE TIMESTAMP INDEX
-- ==========================================================

CREATE INDEX IF NOT EXISTS idx_gps_points_recorded_at
ON gps_points (recorded_at);


-- ==========================================================
-- 8. COUNT GPS RECORDS
-- ==========================================================

SELECT COUNT(*) AS total_gps_records
FROM gps_points;


-- ==========================================================
-- 9. COUNT UNIQUE DEVICES
-- ==========================================================

SELECT COUNT(DISTINCT device_id) AS unique_devices
FROM gps_points;


-- ==========================================================
-- 10. DEVICE ACTIVITY SUMMARY
-- ==========================================================

SELECT
    device_id,
    COUNT(*) AS total_records,
    MIN(recorded_at) AS first_record,
    MAX(recorded_at) AS last_record
FROM gps_points
GROUP BY device_id
ORDER BY total_records DESC;


-- ==========================================================
-- 11. SPATIAL EXTENT OF GPS DATA
-- ==========================================================

SELECT
    ST_Extent(geom) AS gps_spatial_extent
FROM gps_points;


-- ==========================================================
-- 12. FIND GPS POINTS WITHIN A STUDY AREA
--
-- NOTE:
-- The bounding coordinates below are illustrative only.
-- Replace them with the verified GeoPulse study boundary.
-- ==========================================================

SELECT
    record_id,
    device_id,
    recorded_at,
    latitude,
    longitude
FROM gps_points
WHERE ST_Within(
    geom,
    ST_MakeEnvelope(
        78.35, 17.43,
        78.42, 17.47,
        4326
    )
);


-- ==========================================================
-- 13. DISTANCE BETWEEN CONSECUTIVE GPS POINTS
--
-- Calculates movement distance between consecutive records
-- for each device, ordered by timestamp.
-- Geography returns distance in meters.
-- ==========================================================

WITH ordered_points AS (
    SELECT
        device_id,
        recorded_at,
        geom,
        LAG(recorded_at) OVER (
            PARTITION BY device_id
            ORDER BY recorded_at
        ) AS previous_time,
        LAG(geom) OVER (
            PARTITION BY device_id
            ORDER BY recorded_at
        ) AS previous_geom
    FROM gps_points
)
SELECT
    device_id,
    previous_time,
    recorded_at AS current_time,
    ST_Distance(
        previous_geom::GEOGRAPHY,
        geom::GEOGRAPHY
    ) AS movement_distance_meters
FROM ordered_points
WHERE previous_geom IS NOT NULL
  AND geom IS NOT NULL
ORDER BY device_id, current_time
LIMIT 100;


-- ==========================================================
-- 14. GPS POINTS WITHIN 500 METERS OF A LOCATION
--
-- Example location only. Replace with verified coordinates.
-- ==========================================================

SELECT
    record_id,
    device_id,
    recorded_at,
    ST_Distance(
        geom::GEOGRAPHY,
        ST_SetSRID(
            ST_MakePoint(78.38, 17.44),
            4326
        )::GEOGRAPHY
    ) AS distance_meters
FROM gps_points
WHERE ST_DWithin(
    geom::GEOGRAPHY,
    ST_SetSRID(
        ST_MakePoint(78.38, 17.44),
        4326
    )::GEOGRAPHY,
    500
)
ORDER BY distance_meters;


-- ==========================================================
-- 15. CHECK INVALID OR EMPTY GEOMETRIES
-- ==========================================================

SELECT
    COUNT(*) AS missing_geometry_records
FROM gps_points
WHERE geom IS NULL
   OR ST_IsEmpty(geom);


-- ==========================================================
-- 16. CHECK COORDINATE VALIDITY
-- ==========================================================

SELECT *
FROM gps_points
WHERE latitude NOT BETWEEN -90 AND 90
   OR longitude NOT BETWEEN -180 AND 180;


-- ==========================================================
-- END OF SPATIAL FOUNDATION
-- ==========================================================