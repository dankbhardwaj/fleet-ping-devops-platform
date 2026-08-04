// VexarDrive - Fleet Ping Service
// Production Improvement - Sprint 1 Task 1.1
// Configuration Externalization

require("dotenv").config();

const express = require("express");
const { Client } = require("pg");
const jwt = require("jsonwebtoken");

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

// ----------------------------------------------------
// Database Configuration
// ----------------------------------------------------

const DB_CONFIG = {
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
};

// ----------------------------------------------------
// JWT Configuration
// ----------------------------------------------------

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

  const client = new Client(DB_CONFIG);

  try {
    await client.connect();

    await client.query(
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
  } finally {
    await client.end();
  }
});

// Driver Login
app.post("/api/auth/login", async (req, res) => {
  const { phone, otp } = req.body;

  const client = new Client(DB_CONFIG);

  await client.connect();

  const result = await client.query(
    `SELECT * FROM drivers WHERE phone = '${phone}'`
  );

  await client.end();

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
});

// Admin Endpoint
app.get("/api/admin/drivers", async (req, res) => {
  const client = new Client(DB_CONFIG);

  await client.connect();

  const result = await client.query(`SELECT * FROM drivers`);

  await client.end();

  res.json(result.rows);
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

module.exports = app;
