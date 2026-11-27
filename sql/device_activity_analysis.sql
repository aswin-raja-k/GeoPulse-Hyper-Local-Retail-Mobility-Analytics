USE geopulse;

-- 1. GPS records per device
SELECT
    DeviceID,
    COUNT(*) AS total_records
FROM gps_data
GROUP BY DeviceID
ORDER BY total_records DESC;

-- 2. Devices with the highest GPS activity
SELECT
    DeviceID,
    COUNT(*) AS gps_record_count
FROM gps_data
GROUP BY DeviceID
ORDER BY gps_record_count DESC
LIMIT 10;

-- 3. Devices with more than 100 GPS records
SELECT
    DeviceID,
    COUNT(*) AS gps_record_count
FROM gps_data
GROUP BY DeviceID
HAVING COUNT(*) > 100
ORDER BY gps_record_count DESC;

-- 4. Device activity summary
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT DeviceID) AS total_devices,
    AVG(device_records) AS average_records_per_device,
    MAX(device_records) AS maximum_records_per_device,
    MIN(device_records) AS minimum_records_per_device
FROM (
    SELECT
        DeviceID,
        COUNT(*) AS device_records
    FROM gps_data
    GROUP BY DeviceID
) AS device_summary;

-- 5. Devices and their first/last recorded activity
SELECT
    DeviceID,
    MIN(`Timestamp`) AS first_activity,
    MAX(`Timestamp`) AS last_activity,
    COUNT(*) AS total_records
FROM gps_data
GROUP BY DeviceID
ORDER BY first_activity;

-- 6. Device activity classification
SELECT
    DeviceID,
    COUNT(*) AS total_records,
    CASE
        WHEN COUNT(*) >= 1000 THEN 'High Activity'
        WHEN COUNT(*) >= 100 THEN 'Medium Activity'
        ELSE 'Low Activity'
    END AS activity_level
FROM gps_data
GROUP BY DeviceID
ORDER BY total_records DESC;