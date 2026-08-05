# Engineering Decisions

## Why Environment Variables?

Secrets should never be stored in source code.

Environment variables provide separation between application code and deployment configuration.

---

## Why PostgreSQL Connection Pool?

Creating a new connection for every request does not scale.

A shared connection pool:

- reduces latency
- reduces database load
- improves throughput

---

## Why Parameterized Queries?

Parameterized queries eliminate SQL Injection risks.

They separate SQL statements from user input.

---

## Why Docker Health Checks?

The application should only start after PostgreSQL is healthy.

Health checks reduce startup failures.

---

## Why Automatic Schema Initialization?

New developers should be able to clone the repository and start the environment without manually creating database tables.
