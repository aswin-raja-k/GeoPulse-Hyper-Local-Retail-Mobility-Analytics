USE geopulse;

-- 1. View GPS records
SELECT * FROM gps_data;

-- 2. Count total GPS records
SELECT COUNT(*) AS total_records
FROM gps_data;

-- 3. Identify missing values
SELECT *
FROM gps_data
WHERE DeviceID IS NULL
   OR Latitude IS NULL
   OR Longitude IS NULL
   OR Timestamp IS NULL;

-- 4. Check invalid latitude and longitude
SELECT *
FROM gps_data
WHERE Latitude NOT BETWEEN -90 AND 90
   OR Longitude NOT BETWEEN -180 AND 180;

-- 5. Identify duplicate GPS records
SELECT DeviceID, Latitude, Longitude, Timestamp,
       COUNT(*) AS duplicate_count
FROM gps_data
GROUP BY DeviceID, Latitude, Longitude, Timestamp
HAVING COUNT(*) > 1;

-- 6. Count unique devices
SELECT COUNT(DISTINCT DeviceID) AS unique_devices
FROM gps_data;