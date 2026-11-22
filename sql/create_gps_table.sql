
-- GeoPulse GPS Table Creation

USE geopulse;

CREATE TABLE IF NOT EXISTS gps_data (
    GPSRecordID BIGINT AUTO_INCREMENT PRIMARY KEY,
    DeviceID VARCHAR(100),
    Latitude DECIMAL(10,7),
    Longitude DECIMAL(10,7),
    `Timestamp` DATETIME
);

-- Verify table creation
SHOW TABLES;

-- View table structure
DESCRIBE gps_data;
