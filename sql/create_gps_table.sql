USE geopulse;

CREATE TABLE IF NOT EXISTS gps_data (
    GPSRecordID BIGINT AUTO_INCREMENT PRIMARY KEY,
    DeviceID VARCHAR(100) NOT NULL,
    Latitude DECIMAL(10, 7),
    Longitude DECIMAL(10, 7),
    Timestamp DATETIME
);


CREATE TABLE IF NOT EXISTS gps_data (
    GPSRecordID BIGINT AUTO_INCREMENT PRIMARY KEY,
    DeviceID VARCHAR(100) NOT NULL,
    Latitude DECIMAL(10, 7) NOT NULL,
    Longitude DECIMAL(10, 7) NOT NULL,
    Timestamp DATETIME NOT NULL,

    CONSTRAINT chk_latitude
        CHECK (Latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_longitude
        CHECK (Longitude BETWEEN -180 AND 180)
);
