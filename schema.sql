CREATE TABLE IF NOT EXISTS drivers (
    id SERIAL PRIMARY KEY,
    phone VARCHAR(15) UNIQUE NOT NULL,
    name VARCHAR(100),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS fleet_pings (
    id SERIAL PRIMARY KEY,
    vehicle_id VARCHAR(50) NOT NULL,
    lat DECIMAL(9, 6) NOT NULL,
    lng DECIMAL(9, 6) NOT NULL,
    speed DECIMAL(5, 2),
    ts TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fleet_pings_latitude_check
        CHECK (lat >= -90 AND lat <= 90),

    CONSTRAINT fleet_pings_longitude_check
        CHECK (lng >= -180 AND lng <= 180),

    CONSTRAINT fleet_pings_speed_check
        CHECK (speed IS NULL OR speed >= 0)
);

CREATE INDEX IF NOT EXISTS idx_fleet_pings_vehicle_id
    ON fleet_pings (vehicle_id);

CREATE INDEX IF NOT EXISTS idx_fleet_pings_timestamp
    ON fleet_pings (ts);
