import numpy as np
import pandas as pd
from pathlib import Path

INPUT = Path('/mnt/data/Simulated GPS Dataset CSV (1).csv')
OUTPUT = Path('/mnt/data/GeoPulse_Madhapur_5000.csv')
REPORT = Path('/mnt/data/GeoPulse_validation_report.txt')

# Operational rectangular study boundary for the Madhapur locality.
# This is an approximate study-area envelope, not an official ward polygon.
LAT_MIN, LAT_MAX = 17.4302, 17.4504
LON_MIN, LON_MAX = 78.3640, 78.3934
N_DEVICES, RECORDS_PER_DEVICE = 50, 100
SEED = 20261127
rng = np.random.default_rng(SEED)

source = pd.read_csv(INPUT)
ids = list(source['DeviceID'].dropna().astype(str).unique())
if len(ids) < N_DEVICES:
    ids.extend([f'DEV-SIM-{i:04d}' for i in range(len(ids), N_DEVICES)])
ids = ids[:N_DEVICES]

lat_mid = (LAT_MIN + LAT_MAX) / 2
meters_per_lat = 111_320.0
meters_per_lon = 111_320.0 * np.cos(np.deg2rad(lat_mid))
width_m = (LON_MAX - LON_MIN) * meters_per_lon
height_m = (LAT_MAX - LAT_MIN) * meters_per_lat

rows = []
start_base = pd.Timestamp('2026-11-01 06:00:00')
for device_idx, device_id in enumerate(ids):
    # Each device follows a correlated random walk around a home/work anchor.
    x = rng.uniform(0.12, 0.88) * width_m
    y = rng.uniform(0.12, 0.88) * height_m
    anchor_x, anchor_y = x, y
    heading = rng.uniform(-np.pi, np.pi)
    ts = start_base + pd.Timedelta(minutes=int(rng.integers(0, 180)))
    for j in range(RECORDS_PER_DEVICE):
        if j:
            interval_min = int(rng.integers(20, 91))
            ts += pd.Timedelta(minutes=interval_min)
            # Occasional stationary/low-motion periods; otherwise local walking/vehicle movement.
            if rng.random() < 0.22:
                distance = float(rng.uniform(0, 12))
            else:
                heading = 0.72 * heading + 0.28 * rng.uniform(-np.pi, np.pi)
                speed = float(rng.uniform(0.25, 2.2))
                if rng.random() < 0.12:
                    speed = float(rng.uniform(2.2, 5.0))
                distance = min(speed * interval_min * 60, 850.0)
            # Gradual pull toward the device's anchor prevents unrealistic drift across the whole city.
            dx = distance * np.cos(heading) + 0.035 * (anchor_x - x)
            dy = distance * np.sin(heading) + 0.035 * (anchor_y - y)
            x += dx
            y += dy
            # Reflect at study-area edges so every point remains inside the defined envelope.
            x = min(max(x, 0.0), width_m)
            y = min(max(y, 0.0), height_m)
        lat = LAT_MIN + y / meters_per_lat
        lon = LON_MIN + x / meters_per_lon
        rows.append((device_id, round(lat, 6), round(lon, 6), ts.strftime('%Y-%m-%d %H:%M:%S')))

out = pd.DataFrame(rows, columns=['DeviceID', 'Latitude', 'Longitude', 'Timestamp'])
out = out.sort_values(['DeviceID', 'Timestamp'], kind='stable').reset_index(drop=True)
out.to_csv(OUTPUT, index=False)

# Validation
check = pd.read_csv(OUTPUT, parse_dates=['Timestamp'])
per_device = check.groupby('DeviceID').agg(count=('Timestamp', 'size'), chronological=('Timestamp', lambda x: x.is_monotonic_increasing))
# Calculate consecutive-point displacement and implied speed per device.
lat_rad = np.deg2rad(check['Latitude'])
lon_rad = np.deg2rad(check['Longitude'])
check['_prev_lat'] = check.groupby('DeviceID')['Latitude'].shift()
check['_prev_lon'] = check.groupby('DeviceID')['Longitude'].shift()
check['_prev_ts'] = check.groupby('DeviceID')['Timestamp'].shift()
dlat = np.deg2rad(check['Latitude'] - check['_prev_lat'])
dlon = np.deg2rad(check['Longitude'] - check['_prev_lon'])
a = np.sin(dlat/2)**2 + np.cos(np.deg2rad(check['Latitude'])) * np.cos(np.deg2rad(check['_prev_lat'])) * np.sin(dlon/2)**2
distance_m = 6_371_000 * 2 * np.arcsin(np.sqrt(a.clip(lower=0)))
seconds = (check['Timestamp'] - check['_prev_ts']).dt.total_seconds()
speed = distance_m / seconds
valid_speed = speed.dropna()

checks = {
    'Exactly 5,000 records': len(check) == 5000,
    'Exactly 50 unique devices': check['DeviceID'].nunique() == 50,
    'Exactly four approved columns': list(check.columns[:4]) == ['DeviceID','Latitude','Longitude','Timestamp'],
    'No missing values in required columns': not check[['DeviceID','Latitude','Longitude','Timestamp']].isna().any().any(),
    'All latitudes inside study envelope': check['Latitude'].between(LAT_MIN, LAT_MAX).all(),
    'All longitudes inside study envelope': check['Longitude'].between(LON_MIN, LON_MAX).all(),
    '100 records per device': (per_device['count'] == 100).all(),
    'Timestamps chronological per device': per_device['chronological'].all(),
    'No duplicate device-timestamp pairs': not check.duplicated(['DeviceID','Timestamp']).any(),
    'All consecutive intervals positive': (seconds.dropna() > 0).all(),
    'All implied speeds <= 15 m/s': (valid_speed <= 15).all(),
}

report_lines = [
    'GeoPulse Madhapur GPS Dataset — Validation Report',
    '=' * 54,
    f'Generated file: {OUTPUT.name}',
    f'Input file: {INPUT.name}',
    f'Random seed: {SEED}',
    '',
    'Study-area definition',
    f'Latitude: {LAT_MIN} to {LAT_MAX}',
    f'Longitude: {LON_MIN} to {LON_MAX}',
    'Boundary type: approximate rectangular operational envelope around Madhapur, Hyderabad.',
    'Note: This is not an official administrative polygon; confirm/replace with an approved GIS boundary if one is supplied.',
    '',
    'Dataset summary',
    f'Total records: {len(check):,}',
    f'Unique devices: {check["DeviceID"].nunique():,}',
    f'Records per device: min={per_device["count"].min()}, max={per_device["count"].max()}',
    f'Latitude range: {check["Latitude"].min():.6f} to {check["Latitude"].max():.6f}',
    f'Longitude range: {check["Longitude"].min():.6f} to {check["Longitude"].max():.6f}',
    f'Timestamp range: {check["Timestamp"].min()} to {check["Timestamp"].max()}',
    f'Maximum implied consecutive-point speed: {valid_speed.max():.3f} m/s',
    f'Median implied consecutive-point speed: {valid_speed.median():.3f} m/s',
    '',
    'Validation checks',
]
for name, passed in checks.items():
    report_lines.append(f'{"PASS" if passed else "FAIL"}: {name}')
report_lines += ['', f'Overall result: {"PASS" if all(checks.values()) else "FAIL"}',
                 '', 'Movement model: device-specific correlated random walks with occasional stationary periods,',
                 'bounded local movement, chronological timestamps, and boundary reflection.',
                 'Data status: fully simulated; not collected from real GPS devices.']
REPORT.write_text('\n'.join(report_lines), encoding='utf-8')
print('\n'.join(report_lines))
print('\nFILES')
print(OUTPUT, OUTPUT.stat().st_size)
print(REPORT, REPORT.stat().st_size)
print(Path('/mnt/data/generate_geopulse_dataset.py'), Path('/mnt/data/generate_geopulse_dataset.py').stat().st_size)
