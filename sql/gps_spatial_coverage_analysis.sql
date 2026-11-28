
USE geopulse;

-- 1. Overall geographical coverage
SELECT
    COUNT(*) AS total_gps_records,
    COUNT(DISTINCT DeviceID) AS total_devices,
    MIN(Latitude) AS minimum_latitude,
    MAX(Latitude) AS maximum_latitude,
    MIN(Longitude) AS minimum_longitude,
    MAX(Longitude) AS maximum_longitude
FROM gps_data
WHERE Latitude BETWEEN -90 AND 90
  AND Longitude BETWEEN -180 AND 180;

-- 2. Divide geographical locations into grid cells
-- Each cell represents approximately 0.01 degrees.
SELECT
    FLOOR(Latitude * 100) / 100 AS latitude_cell,
    FLOOR(Longitude * 100) / 100 AS longitude_cell,
    COUNT(*) AS gps_record_count,
    COUNT(DISTINCT DeviceID) AS unique_devices
FROM gps_data
WHERE Latitude BETWEEN -90 AND 90
  AND Longitude BETWEEN -180 AND 180
GROUP BY
    FLOOR(Latitude * 100) / 100,
    FLOOR(Longitude * 100) / 100
ORDER BY gps_record_count DESC;

-- 3. Identify the top 10 GPS-dense geographical areas
SELECT
    FLOOR(Latitude * 100) / 100 AS latitude_cell,
    FLOOR(Longitude * 100) / 100 AS longitude_cell,
    COUNT(*) AS gps_record_count,
    COUNT(DISTINCT DeviceID) AS unique_devices
FROM gps_data
WHERE Latitude BETWEEN -90 AND 90
  AND Longitude BETWEEN -180 AND 180
GROUP BY
    FLOOR(Latitude * 100) / 100,
    FLOOR(Longitude * 100) / 100
ORDER BY gps_record_count DESC
LIMIT 10;

-- 4. Analyse geographical coverage by individual device
SELECT
    DeviceID,
    COUNT(*) AS total_records,
    MIN(Latitude) AS minimum_latitude,
    MAX(Latitude) AS maximum_latitude,
    MIN(Longitude) AS minimum_longitude,
    MAX(Longitude) AS maximum_longitude
FROM gps_data
WHERE Latitude BETWEEN -90 AND 90
  AND Longitude BETWEEN -180 AND 180
GROUP BY DeviceID
ORDER BY total_records DESC;

-- 5. Count devices recorded in each geographical grid cell
SELECT
    FLOOR(Latitude * 100) / 100 AS latitude_cell,
    FLOOR(Longitude * 100) / 100 AS longitude_cell,
    COUNT(DISTINCT DeviceID) AS devices_in_area
FROM gps_data
WHERE Latitude BETWEEN -90 AND 90
  AND Longitude BETWEEN -180 AND 180
GROUP BY
    FLOOR(Latitude * 100) / 100,
    FLOOR(Longitude * 100) / 100
ORDER BY devices_in_area DESC;

-- 6. Daily GPS density by geographical area
SELECT
    DATE(`Timestamp`) AS activity_date,
    FLOOR(Latitude * 100) / 100 AS latitude_cell,
    FLOOR(Longitude * 100) / 100 AS longitude_cell,
    COUNT(*) AS gps_record_count,
    COUNT(DISTINCT DeviceID) AS unique_devices
FROM gps_data
WHERE Latitude BETWEEN -90 AND 90
  AND Longitude BETWEEN -180 AND 180
  AND `Timestamp` IS NOT NULL
GROUP BY
    DATE(`Timestamp`),
    FLOOR(Latitude * 100) / 100,
    FLOOR(Longitude * 100) / 100
ORDER BY activity_date, gps_record_count DESC;
