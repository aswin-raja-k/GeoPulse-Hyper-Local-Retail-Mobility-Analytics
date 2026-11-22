
-- GeoPulse GPS Data Validation Queries

USE geopulse;

-- 1. View GPS records
SELECT *
FROM gps_data;

-- 2. Count total GPS records
SELECT COUNT(*) AS total_records
FROM gps_data;

-- 3. Identify missing values
SELECT *
FROM gps_data
WHERE DeviceID IS NULL
   OR TRIM(DeviceID) = ''
   OR Latitude IS NULL
   OR Longitude IS NULL
   OR `Timestamp` IS NULL;

-- 4. Check invalid latitude and longitude ranges
SELECT *
FROM gps_data
WHERE Latitude < -90
   OR Latitude > 90
   OR Longitude < -180
   OR Longitude > 180;

-- 5. Identify duplicate GPS records
SELECT
    DeviceID,
    Latitude,
    Longitude,
    `Timestamp`,
    COUNT(*) AS duplicate_count
FROM gps_data
GROUP BY
    DeviceID,
    Latitude,
    Longitude,
    `Timestamp`
HAVING COUNT(*) > 1;

-- 6. Count unique devices
SELECT COUNT(DISTINCT DeviceID) AS unique_devices
FROM gps_data;

-- 7. Identify records with zero coordinates
SELECT *
FROM gps_data
WHERE Latitude = 0
  AND Longitude = 0;

-- 8. Identify future timestamps
SELECT *
FROM gps_data
WHERE `Timestamp` > NOW();

-- 9. Count GPS records for each device
SELECT
    DeviceID,
    COUNT(*) AS total_gps_records
FROM gps_data
GROUP BY DeviceID
ORDER BY total_gps_records DESC;

-- 10. Identify devices with multiple GPS records
SELECT
    DeviceID,
    COUNT(*) AS record_count
FROM gps_data
GROUP BY DeviceID
HAVING COUNT(*) > 1;

-- 11. Calculate geographical coverage
SELECT
    MIN(Latitude) AS minimum_latitude,
    MAX(Latitude) AS maximum_latitude,
    MIN(Longitude) AS minimum_longitude,
    MAX(Longitude) AS maximum_longitude
FROM gps_data;
