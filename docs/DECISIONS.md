# Engineering Decisions

## Purpose

This document explains the engineering decisions made while improving the Fleet Ping Service for production deployment.

Each decision was made by considering:

- Security
- Maintainability
- Scalability
- Operational simplicity
- Reliability
- Cost efficiency

The goal is to document **why** architectural decisions were made instead of only documenting **what** was implemented.

---

# 1. Configuration Management

## Decision

Use environment variables instead of hardcoded configuration.

## Why?

The original application stored database credentials and JWT secrets directly inside the source code.

Hardcoded secrets:

- expose credentials in source control
- cannot be rotated easily
- prevent environment-specific deployments
- increase security risks

## Alternatives Considered

- Hardcoded configuration
- Configuration files committed to Git

Both were rejected because they expose sensitive information.

## Production Approach

Configuration is now externalized using environment variables.

The design also prepares the application for Azure Key Vault integration.

---

# 2. PostgreSQL Connection Pool

## Decision

Use PostgreSQL connection pooling (`pg.Pool`).

## Why?

Creating a new database connection for every request does not scale.

Connection pooling:

- reduces latency
- improves throughput
- prevents connection exhaustion
- improves application scalability

## Alternatives Considered

Creating a new PostgreSQL connection for every request.

Rejected because it performs poorly under production workloads.

---

# 3. Parameterized SQL Queries

## Decision

Replace dynamic SQL with parameterized queries.

## Why?

Parameterized queries eliminate SQL Injection attacks by separating SQL statements from user input.

## Benefits

- Improved application security
- Database integrity protection
- Secure coding best practices

---

# 4. Request Validation

## Decision

Validate incoming request payloads before executing business logic.

## Why?

Invalid requests should never reach the database.

Benefits include:

- Better API reliability
- Cleaner error handling
- Reduced invalid data
- More predictable behavior

---

# 5. JWT Authentication

## Decision

Protect administrative APIs using JWT authentication.

## Why?

Administrative endpoints should never be publicly accessible.

JWT authentication provides:

- Stateless authentication
- Cloud-native compatibility
- Horizontal scalability
- Simpler deployment

## Future Improvement

Introduce Role-Based Access Control (RBAC).

---

# 6. Health & Readiness Endpoints

## Decision

Expose separate health and readiness endpoints.

## Why?

Health and readiness represent different operational states.

### Health

Indicates whether the application process is running.

### Readiness

Indicates whether the application is capable of serving production traffic.

The readiness endpoint verifies PostgreSQL connectivity before returning READY.

## Benefits

Compatible with:

- Azure Container Apps
- Azure Kubernetes Service (AKS)
- Docker HEALTHCHECK
- Load Balancers

---

# 7. Multi-Stage Docker Build

## Decision

Use a multi-stage Docker build.

## Why?

Multi-stage builds separate dependency installation from the runtime image.

Benefits:

- Smaller image
- Faster deployments
- Reduced attack surface
- Cleaner runtime image

---

# 8. Non-Root Container

## Decision

Run the application as a non-root user.

## Why?

Running containers as root increases the impact of container compromise.

Following the principle of least privilege improves overall container security.

---

# 9. Node.js Alpine Runtime

## Decision

Use the official Node.js Alpine image.

## Why?

Compared to standard Node.js images, Alpine provides:

- Smaller image size
- Reduced attack surface
- Faster downloads
- Faster startup

---

# 10. Docker Networking

## Decision

Use Docker service discovery instead of localhost.

## Why?

Containers communicate through Docker's internal network.

Instead of:

```
DB_HOST=localhost
```

Docker containers use:

```
DB_HOST=db
```

This reflects production container networking.

---

# 11. Environment Separation

## Decision

Maintain separate configurations for local development and Docker.

## Why?

Local execution and container execution require different database hosts.

Local:

```
DB_HOST=localhost
```

Docker:

```
DB_HOST=db
```

Benefits:

- Better portability
- Easier onboarding
- Reduced deployment mistakes

---

# 12. Automatic Database Initialization

## Decision

Automatically initialize PostgreSQL during container startup.

## Why?

A developer should be able to clone the repository and immediately start the application.

Benefits:

- Faster onboarding
- Consistent environments
- Repeatable deployments

---

# 13. Docker Health Checks

## Decision

Configure Docker health checks for both the application and PostgreSQL.

## Why?

Health checks allow container platforms to determine service health automatically.

Benefits:

- Automatic recovery
- Improved reliability
- Safer deployments

---

# 14. Infrastructure as Code

## Decision

Provision Azure infrastructure using Terraform.

## Why?

Infrastructure should be version controlled exactly like application code.

Benefits:

- Version-controlled infrastructure
- Repeatable deployments
- Easier disaster recovery
- Peer review through Pull Requests
- Consistent environments

---

# 15. Azure Virtual Network

## Decision

Deploy application resources inside a dedicated Virtual Network.

## Why?

Private networking improves security and allows managed Azure services to communicate securely.

Benefits:

- Network isolation
- Improved security
- Easier future expansion
- Enterprise architecture alignment

---

# 16. Network Security Groups

## Decision

Protect Azure subnets using Network Security Groups.

## Why?

NSGs restrict unnecessary network traffic and enforce network-level security.

Benefits:

- Least privilege networking
- Better compliance
- Reduced attack surface

---

# 17. Azure Container Registry

## Decision

Use Azure Container Registry (ACR).

## Why?

Container images should be stored in a private enterprise registry.

Benefits:

- Secure image storage
- Azure integration
- Faster deployments
- Image versioning

---

# 18. Azure Log Analytics Workspace

## Decision

Create a centralized Log Analytics Workspace.

## Why?

Logs from Azure services should be collected in a single location.

Benefits:

- Centralized logging
- Operational monitoring
- Easier troubleshooting
- Azure Monitor integration

---

# 19. Azure Container Apps Environment

## Decision

Deploy the application into Azure Container Apps.

## Why?

Azure Container Apps provides managed containers without requiring Kubernetes management.

Benefits:

- Automatic scaling
- HTTPS
- Managed ingress
- Revision management
- Lower operational overhead

---

# 20. Azure PostgreSQL Flexible Server

## Decision

Use Azure Database for PostgreSQL Flexible Server.

## Why?

Managed database services reduce operational complexity.

Benefits:

- Automatic backups
- Managed patching
- High availability support
- Better reliability

---

# 21. Private PostgreSQL Networking

## Decision

Deploy PostgreSQL without public network access.

## Why?

Databases should not be exposed directly to the Internet.

Benefits:

- Reduced attack surface
- Private VNet communication
- Improved compliance
- Better enterprise security

---

# Future Engineering Decisions

The following improvements will be implemented in upcoming phases:

- Azure Key Vault
- Managed Identity
- Secret Rotation
- GitHub Actions CI/CD
- Azure Monitor Alerts
- Remote Terraform Backend
- Autoscaling Policies
- Azure RBAC
- Production Monitoring
- Disaster Recovery Strategy