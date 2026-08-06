# Engineering Decisions

## Purpose

This document explains the engineering decisions made while improving the Fleet Ping Service for production deployment.

Each decision was made by considering security, maintainability, scalability, operational simplicity, and cost.

---

# 1. Configuration Management

## Decision

Use environment variables instead of hardcoded configuration.

## Why?

The original application stored database credentials and JWT secrets directly in the source code.

Hardcoded secrets are one of the highest security risks in production because they:

- expose credentials in source control
- cannot be rotated easily
- prevent environment-specific configuration

## Alternatives Considered

- Hardcoded configuration
- Configuration files committed to Git

Both were rejected because they expose sensitive information.

## Production Approach

Environment variables are used today.

The design also prepares the application for Azure Key Vault integration in later phases.

---

# 2. PostgreSQL Connection Pool

## Decision

Use `pg.Pool` instead of creating a new database connection for every request.

## Why?

Opening a database connection for every request is expensive.

Connection pooling:

- reduces latency
- improves throughput
- prevents connection exhaustion
- scales better during traffic spikes

## Alternatives Considered

Creating a new connection per request.

Rejected because it does not scale in production.

---

# 3. Parameterized SQL Queries

## Decision

Replace string-built SQL queries with parameterized queries.

## Why?

Parameterized queries prevent SQL Injection attacks by separating SQL statements from user input.

## Security Benefit

Protects database integrity while following secure coding practices.

---

# 4. Request Validation

## Decision

Validate incoming API requests before executing business logic.

## Why?

Invalid requests should fail immediately rather than reaching the database.

Benefits include:

- better API reliability
- improved error handling
- protection against malformed requests

---

# 5. JWT Authentication

## Decision

Protect administrative endpoints using JWT authentication.

## Why?

Administrative APIs should never be publicly accessible.

JWT authentication provides:

- stateless authentication
- scalability
- compatibility with cloud-native applications

## Future Improvement

Implement role-based authorization (RBAC) so administrative privileges are separated from standard users.

---

# 6. Health & Readiness Endpoints

## Decision

Expose separate health and readiness endpoints.

## Why?

Health and readiness represent different operational states.

### Health

Indicates whether the application process is running.

### Readiness

Indicates whether the application can safely receive production traffic.

The readiness endpoint verifies PostgreSQL connectivity before reporting READY.

## Benefit

Supports:

- Azure Container Apps
- Azure Kubernetes Service (AKS)
- Docker health checks

---

# 7. Multi-Stage Docker Build

## Decision

Use a multi-stage Docker build.

## Why?

Multi-stage builds reduce image size by excluding unnecessary build artifacts from the runtime image.

Benefits include:

- faster image downloads
- faster deployments
- reduced attack surface

---

# 8. Non-Root Container

## Decision

Run the application as a non-root user.

## Why?

Running containers as root increases the impact of a container compromise.

Following the principle of least privilege improves container security.

---

# 9. Alpine Linux Base Image

## Decision

Use Node.js 22 Alpine.

## Why?

Compared with standard Node.js images, Alpine provides:

- significantly smaller image size
- reduced attack surface
- faster container startup

---

# 10. Docker Networking

## Decision

Use Docker service discovery instead of localhost.

## Why?

Containers communicate through Docker's internal network.

The application connects to PostgreSQL using:

```
DB_HOST=db
```

instead of:

```
localhost
```

This reflects how services communicate inside production container platforms.

---

# 11. Environment Separation

## Decision

Separate local development configuration from Docker configuration.

## Why?

Local execution and Docker execution require different database hosts.

Local development:

```
DB_HOST=localhost
```

Docker:

```
DB_HOST=db
```

Keeping separate environment configurations improves portability and reduces deployment mistakes.

---

# 12. Automatic Database Initialization

## Decision

Automatically initialize the PostgreSQL schema during container startup.

## Why?

A developer should be able to clone the repository and start the application without manually creating database tables.

Benefits:

- faster onboarding
- consistent environments
- repeatable deployments

---

# 13. Docker Health Checks

## Decision

Configure Docker health checks for the application and PostgreSQL.

## Why?

Health checks allow Docker and container orchestrators to detect unhealthy services automatically.

Benefits include:

- automatic recovery
- safer deployments
- improved availability

---

# Future Engineering Decisions

The following architectural decisions will be implemented during the next phase of the assessment.

- Azure Container Apps
- Azure Key Vault
- Managed Identity
- Azure Database for PostgreSQL Flexible Server
- Azure Monitor
- Log Analytics Workspace
- Terraform Infrastructure as Code
- GitHub Actions CI/CD
- Azure RBAC
- Private Networking

These decisions will be documented after the infrastructure implementation is completed.