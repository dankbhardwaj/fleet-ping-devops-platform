# Engineering Decisions

## Purpose

This document explains the engineering decisions made while modernizing the Fleet Ping Service.

The goal was to improve security, scalability, maintainability, operational reliability, and cloud readiness.

---

# 1. Environment Variables

Environment-specific configuration should never be stored in source code.

Using environment variables allows integration with Azure Key Vault and supports multiple deployment environments.

---

# 2. PostgreSQL Connection Pooling

Creating a new connection for every request is inefficient.

Using `pg.Pool` reduces latency, improves throughput, and prevents connection exhaustion.

---

# 3. Parameterized Queries

Parameterized queries eliminate SQL Injection risks by separating SQL statements from user input.

---

# 4. Docker Networking

Containers communicate using Docker's internal DNS rather than localhost.

Using service names makes deployments portable and reliable.

---

# 5. Automatic Schema Initialization

Mounting `schema.sql` into `/docker-entrypoint-initdb.d/` enables automatic database creation and simplifies onboarding.

---

# 6. Multi-Stage Docker Builds

Separating build and runtime stages produces smaller images, reduces attack surface, and speeds deployments.

---

# 7. Non-Root Containers

Running containers as a non-root user follows the principle of least privilege and improves security.

---

# 8. Health & Readiness Endpoints

Operational endpoints allow orchestration platforms to determine application health and readiness before routing traffic.

---

# 9. Infrastructure as Code

Terraform provides repeatable, version-controlled infrastructure deployment and reduces configuration drift.

---

# 10. Virtual Network Isolation

Application and database resources are placed in separate subnets with Network Security Groups to improve isolation.

---

# 11. Azure Container Registry

Using ACR provides secure image storage and integrates directly with Azure Container Apps.

---

# 12. GitHub Actions

GitHub Actions enables automated validation, Docker builds, and Terraform checks for every code change.

---

# 13. OpenID Connect (OIDC)

OIDC removes the need for long-lived Azure credentials in GitHub by using short-lived tokens issued at deployment time.

---

# 14. Generated Credentials

Terraform's `random_password` resource generates unique passwords during deployment.

This avoids hardcoded credentials and prepares the infrastructure for Azure Key Vault.

---

# 15. Azure Key Vault

## Decision

Use Azure Key Vault for centralized secret management instead of embedding credentials inside Terraform or application code.

## Why?

Azure Key Vault provides:

- Centralized secret storage
- RBAC authorization
- Secret rotation
- Integration with Managed Identity
- Improved compliance

This aligns the infrastructure with enterprise Azure security practices.

# 16. Remote Terraform State

## Decision

Store Terraform state in Azure Blob Storage instead of the local filesystem.

## Why?

Remote state provides:

- Team collaboration
- State locking
- Versioning
- Backup
- Improved reliability

This approach aligns with enterprise Infrastructure as Code practices.

# Future Decisions

The following architectural decisions will be implemented in future phases:

- Azure Key Vault
- Managed Identity
- Private Endpoints
- Terraform Remote State
- Azure Monitor
- Application Insights
- Deployment approvals
- Disaster Recovery