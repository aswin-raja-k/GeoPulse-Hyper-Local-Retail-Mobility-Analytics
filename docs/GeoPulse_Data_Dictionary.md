# GeoPulse GPS Dataset – Data Dictionary

| Column | Data type (cleaned) | Description | Validation rule | Example |
|---|---|---|---|---|
| DeviceID | Text | Unique device identifier; repeated across that device's GPS observations | Must not be blank; trim surrounding whitespace | DEV-150342AB |
| Latitude | Decimal number | GPS latitude in decimal degrees | Numeric and between -90 and +90, inclusive | 17.436623 |
| Longitude | Decimal number | GPS longitude in decimal degrees | Numeric and between -180 and +180, inclusive | 78.374303 |
| Timestamp | Date/time | Date and time at which the GPS observation was recorded | Must parse as a valid date/time; standardized as YYYY-MM-DD HH:MM:SS | 2026-11-01 06:13:00 |

**Dataset grain:** one GPS observation per row. A DeviceID is expected to repeat across multiple observations; it is not a unique row key.
