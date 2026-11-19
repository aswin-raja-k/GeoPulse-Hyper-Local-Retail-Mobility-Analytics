# GeoPulse – GPS Dataset Specification



## 1. Purpose

Define a common GPS data format for generation, cleaning, storage and analysis.



## 2. Required Columns



| Column | Data Type | Description |

|---|---|---|

| DeviceID | String | Synthetic device identifier |

| Latitude | Decimal | GPS latitude |

| Longitude | Decimal | GPS longitude |

| Timestamp | DateTime | Date and time of GPS ping |



## 3. Data Rules

- DeviceID must not be empty.

- DeviceID must use synthetic identifiers.

- Latitude must be between -90 and 90.

- Longitude must be between -180 and 180.

- Timestamp must use a consistent date-time format.

- Missing values and duplicate records must be checked.

- Coordinates must represent valid GPS locations.



## 4. Data Format

- Preferred file format: CSV.

- Use consistent column names.

- Use decimal values for coordinates.

- Use a consistent timestamp format, preferably ISO 8601.



## 5. Data Privacy

- Use simulated GPS records only.

- Do not collect personal information.

- Do not use real device identifiers or private location records.



## 6. Team Usage



| Member | Usage |

|---|---|

| Prasuna | Generate GPS records using Python |

| Poojitha | Clean and validate data using Excel |

| Srivaishnavi | Create MySQL tables and validate records |

| Aswin | Prepare PostGIS spatial analysis |



## 7. Pending Decisions

- Study area and geographical boundaries.

- Number of simulated devices and GPS records.

- GPS generation frequency and time period.

- Store locations and catchment configuration.



## 8. Status

Initial dataset specification documented. Final parameters are pending team confirmation.

