# GeoPulse – MySQL Database Setup and Validation

## 1. Project Objective

To set up the GeoPulse MySQL database and prepare the GPS data table for storing and analysing simulated GPS mobility data.

## 2. Database Details

- **Database Name:** geopulse
- **DBMS:** MySQL Community Server
- **IDE:** MySQL Workbench
- **Table Name:** gps_data

## 3. Database Creation

Created the `geopulse` database using:

```sql
CREATE DATABASE IF NOT EXISTS geopulse;
USE geopulse;
```

## 4. GPS Table Structure

Created the `gps_data` table with the following columns:

| Column | Data Type | Description |
|---|---|---|
| GPSRecordID | BIGINT AUTO_INCREMENT | Primary key |
| DeviceID | VARCHAR(100) | Unique device identifier per record |
| Latitude | DECIMAL(10,7) | GPS latitude |
| Longitude | DECIMAL(10,7) | GPS longitude |
| Timestamp | DATETIME | GPS record timestamp |

### Table Creation SQL

```sql
CREATE TABLE IF NOT EXISTS gps_data (
    GPSRecordID BIGINT AUTO_INCREMENT PRIMARY KEY,
    DeviceID VARCHAR(100) NOT NULL,
    Latitude DECIMAL(10,7) NOT NULL,
    Longitude DECIMAL(10,7) NOT NULL,
    Timestamp DATETIME NOT NULL,

    CONSTRAINT chk_latitude
        CHECK (Latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_longitude
        CHECK (Longitude BETWEEN -180 AND 180)
);
```

## 5. SQL Data Validation

Prepared SQL queries for the following checks:

1. View GPS records.
2. Count total GPS records.
3. Identify missing values.
4. Check invalid latitude and longitude values.
5. Identify duplicate GPS records.
6. Count unique DeviceIDs.
7. Check records with zero coordinates.
8. Identify future timestamps.
9. Count GPS records for each device.
10. Find devices with multiple GPS records.
11. Identify geographical coverage using minimum and maximum coordinates.

## 6. Project Files

| File Name | Purpose |
|---|---|
| createdatabase.sql | Database creation |
| create gps table.sql | GPS table creation |
| validation quries.sql | SQL validation queries |
| GeoPulse_Database_Documentation.md | Project documentation |

## 7. Current Progress

- [x] Database creation SQL prepared.
- [x] GPS table structure prepared.
- [x] Primary key and data types defined.
- [x] Coordinate range constraints added.
- [x] SQL validation queries prepared.
- [ ] Initial CSV dataset received from Prasuna.
- [ ] CSV dataset imported into MySQL.
- [ ] Imported record count verified.
- [ ] Final database validation completed.

## 8. Dependencies

- **Aswin:** Confirmation of the final GPS table structure.
- **Prasuna:** Initial simulated GPS CSV dataset.

## 9. GitHub Details

- **Branch:** `srivaishnavi-sql-analytics`
- **Repository:** GeoPulse project repository.
- **Commit:** Database schema and GPS validation SQL scripts.

## 10. Conclusion

The initial GeoPulse MySQL database structure and SQL validation scripts have been prepared. Dataset import and final validation will be completed after receiving the initial simulated GPS CSV file.