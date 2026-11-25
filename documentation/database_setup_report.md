# GeoPulse – MySQL Database Setup, Validation and GPS Mobility Analysis

## 1. Project Objective

To design and develop the GeoPulse MySQL database for storing, managing, validating, and analysing simulated GPS mobility data.

The database development focuses on GPS table design, SQL-based data validation, device activity analysis, geographical distance calculations, and temporal mobility analysis.

## 2. Database Details

- **Database Name:** `geopulse`
- **DBMS:** MySQL Community Server
- **IDE:** MySQL Workbench
- **Main Table:** `gps_data`
- **Project Domain:** GPS Mobility Data Analysis
- **Programming Language:** SQL

## 3. Database Creation

Created the MySQL database named `geopulse` using the database creation SQL script.

```sql
CREATE DATABASE IF NOT EXISTS geopulse;

USE geopulse;
```

The database provides a structured environment for storing and analysing simulated GPS mobility records.

## 4. GPS Table Structure

Designed the `gps_data` table with the following columns:

| Column | Data Type | Description |
|---|---|---|
| GPSRecordID | BIGINT AUTO_INCREMENT | Unique record identifier and primary key |
| DeviceID | VARCHAR(100) | Identifier of the GPS device |
| Latitude | DECIMAL(10,7) | Geographic latitude |
| Longitude | DECIMAL(10,7) | Geographic longitude |
| Timestamp | DATETIME | Date and time of GPS recording |

### 4.1 Table Design Considerations

- `GPSRecordID` provides a unique identifier for every GPS record.
- `DeviceID` identifies the device generating GPS data.
- `DECIMAL(10,7)` provides precision for latitude and longitude values.
- `DATETIME` stores the GPS recording timestamp.
- `GPSRecordID` is defined as the primary key with `AUTO_INCREMENT`.
- Appropriate constraints are used to maintain data integrity and coordinate validity.

## 5. SQL Data Validation

Developed SQL queries to examine the quality, consistency, and distribution of GPS records.

The validation checks include:

1. Viewing GPS records.
2. Counting total GPS records.
3. Identifying missing values.
4. Checking latitude and longitude ranges.
5. Identifying duplicate GPS records.
6. Counting unique `DeviceID` values.
7. Identifying records with zero coordinates.
8. Detecting future timestamps.
9. Calculating device-wise GPS record counts.
10. Identifying devices with multiple GPS records.
11. Calculating geographical coverage using minimum and maximum coordinates.

### 5.1 Data Quality Validation Criteria

| Validation Area | Expected Check |
|---|---|
| Record Completeness | Identify NULL values in important GPS columns |
| Coordinate Validity | Latitude between -90 and 90; longitude between -180 and 180 |
| Record Uniqueness | Identify duplicate GPS records |
| Device Identification | Count unique GPS devices |
| Timestamp Consistency | Identify future-dated GPS records |
| Coordinate Accuracy | Identify records containing zero coordinates |
| Data Distribution | Examine device-wise record counts and geographical coverage |

These checks help identify incomplete, inconsistent, duplicate, and potentially invalid GPS records before further mobility analysis.

## 6. GPS Mobility and Movement Analysis

Developed an additional SQL module named `device_movement_analysis.sql` to analyse the geographical movement patterns of GPS devices.

### 6.1 Previous Location Identification

- Used the SQL `LAG()` window function to retrieve the previous GPS coordinates of each device.
- Ordered GPS records by timestamp to examine consecutive location updates.
- Compared previous and current GPS positions for individual devices.

### 6.2 Distance Calculation Using the Haversine Formula

- Implemented the Haversine formula to calculate the approximate geographical distance between two consecutive GPS coordinates.
- Calculated distances in kilometres.
- Used Earth's approximate mean radius of 6,371 kilometres.

### 6.3 Estimated Speed Calculation

- Calculated the time difference between consecutive GPS records.
- Estimated movement speed using geographical distance and elapsed time.
- Expressed estimated speed in kilometres per hour.
- Handled zero or negative time intervals to avoid invalid speed calculations.

### 6.4 Device-wise Distance Analysis

- Calculated estimated total movement distance for individual devices.
- Aggregated consecutive GPS movement distances.
- Arranged devices according to their estimated total movement distance.

These operations extend the database module from basic GPS data validation to geographical movement and mobility analysis.

**Note:** Calculated distances and speeds are estimates based on consecutive GPS observations. They do not represent actual road distances or independently verified physical speeds.

## 7. Temporal GPS Activity Analysis

Prepared additional SQL queries to examine the time-based behaviour of GPS devices.

The analysis includes:

1. Identifying the first and last GPS recording timestamps for each device.
2. Calculating time intervals between consecutive GPS records.
3. Identifying GPS recording gaps exceeding 30 minutes.
4. Analysing GPS recording frequency by hour.
5. Generating daily GPS activity summaries.
6. Calculating the number of active devices and GPS records for each day.

These queries help understand GPS recording patterns, recording frequency, and device activity over time.

## 8. Analytical Methodology

The GeoPulse database analysis follows a structured sequence to prepare GPS records for mobility analysis.

### 8.1 Data Preparation

GPS records are stored in the `gps_data` table with device identifiers, geographical coordinates, and recording timestamps.

### 8.2 Data Quality Assessment

SQL validation queries examine missing values, invalid coordinate ranges, duplicate records, zero coordinates, and timestamp consistency.

### 8.3 Device-wise Record Ordering

GPS observations are grouped by `DeviceID` and arranged chronologically to identify consecutive location records for each device.

### 8.4 Movement Estimation

The Haversine formula estimates the geographical distance between consecutive GPS observations. The elapsed time between observations is used to estimate movement speed.

### 8.5 Activity Pattern Analysis

Device-wise and time-based SQL queries help examine recording frequency, daily activity, and gaps between GPS observations.

This methodology establishes a consistent process for analysing simulated GPS records using SQL.

## 9. Project Files

| File Name | Purpose |
|---|---|
| `sql/create_database.sql` | Database creation script |
| `sql/create_gps_table.sql` | GPS table creation script |
| `sql/validation_queries.sql` | SQL data validation and temporal analysis queries |
| `sql/device_movement_analysis.sql` | GPS distance and movement analysis |
| `documentation/database_setup_report.md` | Database setup and technical documentation |
| `README.md` | Project overview and repository guide |
| `gps_data.csv` | Simulated GPS dataset |

## 10. Current Progress

### Completed Development Activities

- [x] Prepared database creation SQL script.
- [x] Designed the GPS table structure.
- [x] Defined the primary key and appropriate data types.
- [x] Prepared SQL data validation queries.
- [x] Added coordinate validation criteria.
- [x] Developed device-wise GPS activity queries.
- [x] Prepared daily GPS recording analysis.
- [x] Prepared temporal recording interval analysis.
- [x] Developed GPS movement distance calculations using the Haversine formula.
- [x] Added estimated device speed calculations.
- [x] Prepared device-wise total distance analysis.
- [x] Documented the analytical methodology and calculation assumptions.
- [x] Updated database technical documentation.
- [x] Organized project files and maintained GitHub version control.

## 11. Dependencies and Coordination

- **Aswin:** Coordination regarding the final GPS table structure.
- **Prasuna:** Simulated GPS CSV dataset generation.

## 12. GitHub Details

- **Assigned Branch:** `srivaishnavi-sql-analytics`
- **Repository:** GeoPulse – Hyper-Local Retail Mobility Analytics
- **Platform:** GitHub

Project SQL scripts, documentation, and development updates are maintained in the assigned GitHub branch. Changes are committed and pushed regularly without making direct commits to the `main` branch.

## 13. Conclusion

The GeoPulse database development covers MySQL database design, GPS table structure preparation, SQL data validation, temporal activity analysis, and geographical movement calculations.

The implementation extends beyond basic database management by incorporating GPS distance estimation, device-wise movement analysis, estimated speed calculations, and time-based activity analysis.

The developed SQL modules establish a foundation for analysing simulated GPS mobility patterns and supporting further geographical and mobility analytics within the GeoPulse project.