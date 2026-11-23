
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


-- 12. Find the first and last GPS activity for each device
SELECT
    DeviceID,
    MIN(Timestamp) AS first_record_time,
    MAX(Timestamp) AS last_record_time,
    COUNT(*) AS total_records
FROM gps_data
GROUP BY DeviceID
ORDER BY DeviceID;


-- 13. Count GPS records generated on each day
SELECT
    DATE(Timestamp) AS recording_date,
    COUNT(*) AS daily_record_count
FROM gps_data
GROUP BY DATE(Timestamp)
ORDER BY recording_date;


-- 14. Find devices with no GPS activity on a particular date
-- Replace the date with the required analysis date
SELECT
    DeviceID,
    COUNT(*) AS records_on_selected_date
FROM gps_data
WHERE DATE(Timestamp) = '2026-11-23'
GROUP BY DeviceID
ORDER BY DeviceID;


-- 15. Calculate the average GPS coordinates for each device
SELECT
    DeviceID,
    ROUND(AVG(Latitude), 7) AS average_latitude,
    ROUND(AVG(Longitude), 7) AS average_longitude,
    COUNT(*) AS total_records
FROM gps_data
GROUP BY DeviceID
ORDER BY DeviceID;
