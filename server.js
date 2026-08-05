// VexarDrive - Fleet Ping Service
// Production Improvement
// Sprint 1 Task 1.2 - PostgreSQL Connection Pool

require("dotenv").config();

const express = require("express");
const jwt = require("jsonwebtoken");
const pool = require("./config/db");

const app = express();

app.use(express.json());

// ----------------------------------------------------
// Validate Required Environment Variables
// ----------------------------------------------------

const requiredEnvVars = [
  "DB_HOST",
  "DB_PORT",
  "DB_NAME",
  "DB_USER",
  "DB_PASSWORD",
  "JWT_SECRET",
];

const missingEnvVars = requiredEnvVars.filter(
  (envVar) => !process.env[envVar]
);

if (missingEnvVars.length > 0) {
  console.error(
    `Missing required environment variables: ${missingEnvVars.join(", ")}`
  );
  process.exit(1);
}

const JWT_SECRET = process.env.JWT_SECRET;

// ----------------------------------------------------
// Routes
// ----------------------------------------------------

app.get("/", (req, res) => {
  res.send("VexarDrive Fleet Ping Service is running");
});

// Fleet vehicle ping ingestion
app.post("/api/fleet/ping", async (req, res) => {
  const { vehicleId, lat, lng, speed, timestamp } = req.body;

  try {
    await pool.query(
      `INSERT INTO fleet_pings (vehicle_id, lat, lng, speed, ts)
       VALUES ($1, $2, $3, $4, $5)`,
      [vehicleId, lat, lng, speed, timestamp]
    );

    res.json({
      status: "ok",
    });
  } catch (err) {
    console.error(err);

    res.status(500).json({
      error: "insert failed",
    });
  }
});

// Driver Login
app.post("/api/auth/login", async (req, res) => {
  const { phone } = req.body;

  try {
    const result = await pool.query(
      `SELECT * FROM drivers WHERE phone = '${phone}'`
    );

    if (result.rows.length === 0) {
      return res.status(401).json({
        error: "not found",
      });
    }

    const token = jwt.sign(
      {
        driverId: result.rows[0].id,
      },
      JWT_SECRET,
      {
        expiresIn: "30d",
      }
    );

    res.json({
      token,
    });
  } catch (err) {
    console.error(err);

    res.status(500).json({
      error: "login failed",
    });
  }
});

// Admin Endpoint
app.get("/api/admin/drivers", async (req, res) => {
  try {
    const result = await pool.query(`SELECT * FROM drivers`);

    res.json(result.rows);
  } catch (err) {
    console.error(err);

    res.status(500).json({
      error: "database error",
    });
  }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

module.exports = app;
