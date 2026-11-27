USE geopulse;

-- 1. Total GPS records
SELECT COUNT(*) AS total_gps_records
FROM gps_data;

-- 2. Total unique devices
SELECT COUNT(DISTINCT DeviceID) AS unique_devices
FROM gps_data;

-- 3. Missing values
SELECT
    SUM(DeviceID IS NULL) AS missing_device_ids,
    SUM(Latitude IS NULL) AS missing_latitudes,
    SUM(Longitude IS NULL) AS missing_longitudes,
    SUM(`Timestamp` IS NULL) AS missing_timestamps
FROM gps_data;

-- 4. Invalid latitude values
SELECT *
FROM gps_data
WHERE Latitude NOT BETWEEN -90 AND 90;

-- 5. Invalid longitude values
SELECT *
FROM gps_data
WHERE Longitude NOT BETWEEN -180 AND 180;

-- 6. Zero coordinates
SELECT *
FROM gps_data
WHERE Latitude = 0 OR Longitude = 0;

-- 7. Future timestamps
SELECT *
FROM gps_data
WHERE `Timestamp` > NOW();

-- 8. Duplicate GPS observations
SELECT
    DeviceID,
    Latitude,
    Longitude,
    `Timestamp`,
    COUNT(*) AS duplicate_count
FROM gps_data
GROUP BY DeviceID, Latitude, Longitude, `Timestamp`
HAVING COUNT(*) > 1;

-- 9. Overall GPS data range
SELECT
    MIN(`Timestamp`) AS first_record,
    MAX(`Timestamp`) AS last_record,
    MIN(Latitude) AS minimum_latitude,
    MAX(Latitude) AS maximum_latitude,
    MIN(Longitude) AS minimum_longitude,
    MAX(Longitude) AS maximum_longitude
FROM gps_data;