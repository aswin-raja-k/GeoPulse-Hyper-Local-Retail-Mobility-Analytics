
# GeoPulse – MySQL Database Setup and Validation

## 1. Project Objective

To design and set up the GeoPulse MySQL database for storing, managing, and analysing simulated GPS mobility data.

The initial phase focuses on database creation, GPS table design, and SQL-based data validation.

## 2. Database Details

- Database Name: geopulse
- DBMS: MySQL Community Server
- IDE: MySQL Workbench
- Table Name: gps_data
- Project Domain: GPS Mobility Data Analysis

## 3. Database Creation

Created the MySQL database named `geopulse` using the database creation SQL script.

The database is used to store and analyse simulated GPS mobility records.

## 4. GPS Table Structure

Designed the `gps_data` table with the following columns:

| Column | Data Type | Description |
|---|---|---|
| GPSRecordID | BIGINT AUTO_INCREMENT | Unique record identifier and primary key |
| DeviceID | VARCHAR(100) | Identifier of the GPS device |
| Latitude | DECIMAL(10,7) | Geographic latitude |
| Longitude | DECIMAL(10,7) | Geographic longitude |
| Timestamp | DATETIME | Date and time of GPS recording |

### Table Design Considerations

- GPSRecordID provides a unique identifier for every GPS record.
- DeviceID identifies the device generating GPS data.
- DECIMAL(10,7) provides precision for latitude and longitude values.
- DATETIME stores the GPS recording timestamp.
- GPS fields are initially nullable to support missing-value validation.
- GPSRecordID is defined as the primary key with AUTO_INCREMENT.

## 5. SQL Data Validation

Prepared SQL queries to examine the quality, consistency, and distribution of GPS records.

The following validation checks are included:

1. View GPS records.
2. Count total GPS records.
3. Identify missing values.
4. Check latitude and longitude ranges.
5. Identify duplicate GPS records.
6. Count unique DeviceIDs.
7. Identify records with zero coordinates.
8. Detect future timestamps.
9. Calculate device-wise GPS record counts.
10. Identify devices with multiple GPS records.
11. Calculate geographical coverage using minimum and maximum coordinates.

### 5.1 Data Quality Validation Criteria

The GPS dataset will be evaluated using the following data-quality criteria:

| Validation Area | Expected Check |
|---|---|
| Record Completeness | Identify NULL values in important GPS columns. |
| Coordinate Validity | Latitude must be between -90 and 90, and longitude between -180 and 180. |
| Record Uniqueness | Identify duplicate GPS records. |
| Device Identification | Verify the number of unique GPS devices. |
| Timestamp Consistency | Identify future-dated GPS records. |
| Coordinate Accuracy | Identify records containing zero coordinates. |
| Data Distribution | Examine device-wise record counts and geographical coverage. |

These checks will help identify incomplete, inconsistent, duplicate, and potentially invalid GPS records before performing further mobility data analysis.

Actual validation outcomes will be documented after importing the simulated GPS dataset into MySQL.


## 6. Project Files

| File Name | Purpose |
|---|---|
| create_database.sql | Database creation script |
| create_gps_table.sql | GPS table creation script |
| validation_queries.sql | SQL data validation queries |
| database_setup_report.md | Database setup and technical documentation |
| README.md | Project overview and repository guide |
| gps_data.csv | Initial simulated GPS dataset |

## 7. Current Progress

### Completed

- [x] Prepared database creation SQL script.
- [x] Designed GPS table structure.
- [x] Defined primary key and appropriate data types.
- [x] Prepared SQL data validation queries.
- [x] Prepared database documentation.
- [x] Organized project folder structure.

### Pending

- [ ] Verify MySQL Community Server and Workbench installation.
- [ ] Confirm final GPS table structure with Aswin.
- [ ] Create and verify the GeoPulse database.
- [ ] Create and verify the GPS table.
- [ ] Receive the initial simulated GPS CSV dataset from Prasuna.
- [ ] Import the CSV dataset into MySQL.
- [ ] Verify the imported record count.
- [ ] Execute validation queries on the imported dataset.
- [ ] Document actual validation results.
- [ ] Commit and push deliverables to the assigned GitHub branch.

## 8. Dependencies and Coordination

- Aswin: Confirmation of the final GPS table structure.
- Prasuna: Generation and sharing of the initial simulated GPS CSV dataset.

Dataset import and final data validation depend on receiving the CSV file.

## 9. GitHub Details

- Assigned Branch: srivaishnavi-sql-analytics
- Repository: GeoPulse project repository.
- Deliverables: SQL scripts, database documentation, and README.

All project changes will be committed and pushed to the assigned branch. No direct commits will be made to the main branch.

## 10. Conclusion

The initial GeoPulse database design, GPS table definition, and SQL data validation queries have been prepared.

The next phase involves confirming the final table structure, creating the database in MySQL, importing the simulated GPS dataset, verifying imported records, and performing data-quality checks.
