# GeoPulse-Hyper-Local-Retail-Mobility-Analytics
Hyper-local retail mobility analytics using data analysis and interactive visualizations.

# GeoPulse – MySQL Database Setup and Validation

## About the Project

GeoPulse is a GPS mobility data project focused on storing, managing, and analysing simulated GPS location records using MySQL.

This phase involves setting up the database, designing the GPS table, and preparing SQL queries for data validation.

## Technologies Used

- MySQL Community Server
- MySQL Workbench
- SQL
- Git and GitHub

## Project Structure

```text
GeoPulse/
├── data/
│   └── gps_data.csv
├── documentation/
│   └── database_setup_report.md
├── sql/
│   ├── create_database.sql
│   ├── create_gps_table.sql
│   └── validation_queries.sql
├── .gitignore
└── README.md
```

## Database Details

- Database: geopulse
- Table: gps_data
- Primary Key: GPSRecordID
- GPS Columns: DeviceID, Latitude, Longitude, Timestamp

## Setup Instructions

1. Install MySQL Community Server and MySQL Workbench.
2. Open MySQL Workbench and connect to the server.
3. Execute `sql/create_database.sql`.
4. Execute `sql/create_gps_table.sql`.
5. Execute `sql/validation_queries.sql` after importing the dataset.

## Data Validation

The SQL scripts include checks for:

- Total GPS records
- Missing values
- Invalid geographical coordinates
- Duplicate GPS records
- Unique devices
- Zero coordinates
- Future timestamps
- Device-wise record counts
- Geographical coverage

## Dataset

The initial simulated GPS dataset will be added to the `data/` directory once provided.

## Documentation

Refer to `documentation/database_setup_report.md` for the database schema, table design, validation procedures, progress, and dependencies.

## GitHub Branch

Assigned branch: `srivaishnavi-sql-analytics`

All project work will be maintained in the assigned branch.
