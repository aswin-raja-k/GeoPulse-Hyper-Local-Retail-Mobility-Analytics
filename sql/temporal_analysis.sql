USE geopulse;

-- 1. GPS records per day
SELECT
    DATE(`Timestamp`) AS activity_date,
    COUNT(*) AS total_records
FROM gps_data
GROUP BY DATE(`Timestamp`)
ORDER BY activity_date;

-- 2. Active devices per day
SELECT
    DATE(`Timestamp`) AS activity_date,
    COUNT(DISTINCT DeviceID) AS active_devices
FROM gps_data
GROUP BY DATE(`Timestamp`)
ORDER BY activity_date;

-- 3. GPS records per hour
SELECT
    HOUR(`Timestamp`) AS activity_hour,
    COUNT(*) AS total_records
FROM gps_data
GROUP BY HOUR(`Timestamp`)
ORDER BY activity_hour;

-- 4. Daily device activity summary
SELECT
    DATE(`Timestamp`) AS activity_date,
    COUNT(*) AS total_gps_records,
    COUNT(DISTINCT DeviceID) AS active_devices,
    AVG(Latitude) AS average_latitude,
    AVG(Longitude) AS average_longitude
FROM gps_data
GROUP BY DATE(`Timestamp`)
ORDER BY activity_date;

-- 5. Time difference between consecutive GPS records per device
WITH ordered_records AS (
    SELECT
        DeviceID,
        GPSRecordID,
        `Timestamp`,
        LAG(`Timestamp`) OVER (
            PARTITION BY DeviceID
            ORDER BY `Timestamp`, GPSRecordID
        ) AS previous_timestamp
    FROM gps_data
)
SELECT
    DeviceID,
    GPSRecordID,
    previous_timestamp,
    `Timestamp` AS current_timestamp,
    TIMESTAMPDIFF(
        MINUTE,
        previous_timestamp,
        `Timestamp`
    ) AS gap_minutes
FROM ordered_records
WHERE previous_timestamp IS NOT NULL
ORDER BY DeviceID, `Timestamp`;

-- 6. Identify recording gaps greater than 30 minutes
WITH ordered_records AS (
    SELECT
        DeviceID,
        GPSRecordID,
        `Timestamp`,
        LAG(`Timestamp`) OVER (
            PARTITION BY DeviceID
            ORDER BY `Timestamp`, GPSRecordID
        ) AS previous_timestamp
    FROM gps_data
)
SELECT
    DeviceID,
    previous_timestamp,
    `Timestamp` AS current_timestamp,
    TIMESTAMPDIFF(
        MINUTE,
        previous_timestamp,
        `Timestamp`
    ) AS gap_minutes
FROM ordered_records
WHERE previous_timestamp IS NOT NULL
  AND TIMESTAMPDIFF(
        MINUTE,
        previous_timestamp,
        `Timestamp`
    ) > 30
ORDER BY gap_minutes DESC;