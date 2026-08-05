// VexarDrive - Fleet Ping Service
// Production Improvements
// Sprint 3 - JWT Authentication

require("dotenv").config();

const express = require("express");
const jwt = require("jsonwebtoken");
const pool = require("./config/db");
const authenticateToken = require("./middleware/auth");

const app = express();

app.use(express.json());

// ----------------------------------------------------
// Validate Environment Variables
// ----------------------------------------------------

const requiredEnvVars = [
  "DB_HOST",
  "DB_PORT",
  "DB_NAME",
  "DB_USER",
  "DB_PASSWORD",
  "JWT_SECRET",
];

const missing = requiredEnvVars.filter(
  (env) => !process.env[env]
);

if (missing.length > 0) {
  console.error(
    `Missing environment variables: ${missing.join(", ")}`
  );
  process.exit(1);
}

const JWT_SECRET = process.env.JWT_SECRET;

// ----------------------------------------------------
// Root
// ----------------------------------------------------

app.get("/", (req, res) => {
  res.send("VexarDrive Fleet Ping Service is running");
});

// ----------------------------------------------------
// Fleet Ping
// ----------------------------------------------------

app.post("/api/fleet/ping", async (req, res) => {

  const { vehicleId, lat, lng, speed, timestamp } = req.body;

  if (!vehicleId || lat === undefined || lng === undefined || !timestamp) {
    return res.status(400).json({
      error: "Invalid request payload",
    });
  }

  try {

    await pool.query(
      `INSERT INTO fleet_pings
      (vehicle_id, lat, lng, speed, ts)
      VALUES ($1,$2,$3,$4,$5)`,
      [vehicleId, lat, lng, speed, timestamp]
    );

    return res.json({
      status: "ok",
    });

  } catch (err) {

    console.error(err);

    return res.status(500).json({
      error: "insert failed",
    });

  }

});

// ----------------------------------------------------
// Driver Login
// ----------------------------------------------------

app.post("/api/auth/login", async (req, res) => {

  const { phone, otp } = req.body;

  if (!phone) {
    return res.status(400).json({
      error: "Phone number is required",
    });
  }

  if (!otp) {
    return res.status(400).json({
      error: "OTP is required",
    });
  }

  try {

    const result = await pool.query(
      "SELECT * FROM drivers WHERE phone = $1",
      [phone]
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

    return res.json({
      token,
    });

  } catch (err) {

    console.error(err);

    return res.status(500).json({
      error: "login failed",
    });

  }

});

// ----------------------------------------------------
// Protected Admin Endpoint
// ----------------------------------------------------

app.get(
  "/api/admin/drivers",
  authenticateToken,
  async (req, res) => {

    try {

      const result = await pool.query(
        "SELECT * FROM drivers"
      );

      return res.json(result.rows);

    } catch (err) {

      console.error(err);

      return res.status(500).json({
        error: "database error",
      });

    }

  }
);

// ----------------------------------------------------

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

module.exports = app;