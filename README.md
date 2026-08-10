# VexarDrive Fleet Ping Service

Production-oriented DevOps platform for a containerized fleet-tracking backend.

This project demonstrates how a Node.js + PostgreSQL application can be developed locally, containerized, secured, validated, scanned, and prepared for deployment to Microsoft Azure using Infrastructure as Code and CI/CD practices.

> **Assessment Note**
>
> The Azure infrastructure and deployment workflows are implemented using Terraform and GitHub Actions.
>
> A live Azure deployment was **not performed** because an Azure subscription was not available during implementation.
>
> All locally testable application, Docker, Terraform, Git, and container-security controls were validated locally.
>
> The repository intentionally distinguishes between **implemented as code** and **actually deployed**.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Problem Statement](#problem-statement)
- [What This Project Demonstrates](#what-this-project-demonstrates)
- [Architecture](#architecture)
- [Application Flow](#application-flow)
- [DevOps Flow](#devops-flow)
- [Technology Stack](#technology-stack)
- [Repository Structure](#repository-structure)
- [Application](#application)
- [API Endpoints](#api-endpoints)
- [Health and Readiness](#health-and-readiness)
- [Docker Implementation](#docker-implementation)
- [Docker Compose](#docker-compose)
- [Container Security](#container-security)
- [Terraform Infrastructure](#terraform-infrastructure)
- [Environment Strategy](#environment-strategy)
- [Azure Architecture](#azure-architecture)
- [Security Architecture](#security-architecture)
- [Secrets Management](#secrets-management)
- [CI/CD](#cicd)
- [Security Scanning](#security-scanning)
- [Testing and Validation](#testing-and-validation)
- [Monitoring and Observability](#monitoring-and-observability)
- [Cost Optimization](#cost-optimization)
- [Deployment Status](#deployment-status)
- [AI Assistance](#ai-assistance)
- [Documentation](#documentation)
- [Screenshots](#screenshots)
- [Production Roadmap](#production-roadmap)
- [Limitations](#limitations)
- [What I Would Do Next](#what-i-would-do-next)
- [Interview Explanation](#interview-explanation)
- [Key Engineering Decisions](#key-engineering-decisions)
- [Final Project Status](#final-project-status)
- [Author](#author)

---

# Project Overview

Fleet Ping Service is a backend service for a fleet-tracking platform.

The application provides APIs for:

- Driver authentication
- Fleet location and telemetry operations
- Administrative operations
- Application health monitoring
- Database readiness verification

The DevOps implementation extends the application with:

- Docker containerization
- Multi-stage Docker builds
- Non-root runtime containers
- Docker Compose
- PostgreSQL
- Terraform Infrastructure as Code
- Microsoft Azure infrastructure configuration
- Azure Container Apps
- Azure Container Registry
- Azure Database for PostgreSQL Flexible Server
- Azure Virtual Network
- Network Security Groups
- Azure Key Vault
- Managed Identity
- Azure RBAC
- GitHub Actions
- GitHub OIDC configuration
- Trivy vulnerability scanning
- Health checks
- Readiness checks
- Azure Monitor configuration
- Log Analytics
- Application Insights configuration
- Environment-specific Terraform configuration
- Production-oriented security controls
- Operational documentation

---

# Problem Statement

A fleet-tracking application requires more than application code.

A production-oriented platform should provide:

- Reproducible infrastructure
- Containerized application delivery
- Secure database connectivity
- Secrets management
- Authentication and authorization
- Infrastructure validation
- CI/CD automation
- Container vulnerability scanning
- Health and readiness checks
- Monitoring
- Logging
- Environment separation
- Cost awareness
- Operational documentation
- Security controls
- Rollback and troubleshooting procedures

This project demonstrates how these requirements can be addressed using modern DevOps and cloud-native practices.

---

# What This Project Demonstrates

| Engineering Layer | Implementation |
|---|---|
| Application | Node.js + Express |
| Database | PostgreSQL |
| Authentication | JWT |
| Containerization | Docker |
| Local Orchestration | Docker Compose |
| Infrastructure | Terraform |
| Cloud Platform | Microsoft Azure |
| Container Platform | Azure Container Apps |
| Image Registry | Azure Container Registry |
| Database Platform | PostgreSQL Flexible Server |
| Networking | Azure VNet + Subnets + NSGs |
| Secrets | Azure Key Vault |
| Identity | Managed Identity |
| Authorization | Azure RBAC |
| CI/CD | GitHub Actions |
| Azure Authentication | GitHub OIDC |
| Security Scanning | Trivy |
| Monitoring | Azure Monitor |
| Logging | Log Analytics |
| Application Telemetry | Application Insights |
| DNS | Private DNS |
| Documentation | Markdown documentation |

---

# Architecture

## High-Level Architecture

```text
                         Developer
                             |
                             v
                     GitHub Repository
                             |
                 +-----------+-----------+
                 |                       |
                 v                       v
          GitHub Actions            Terraform
                 |                       |
          +------+------+          +-----+------+
          |             |          |            |
         CI          Security    Network     Azure Services
          |           Trivy         |            |
          |             |            |            |
          +------+------+            |            |
                 |                   |            |
                 v                   v            v
          Container Image          Azure       Key Vault
                 |                 VNet            |
                 v                   |       Managed Identity
                ACR                  |             |
                 |                   |             |
                 v                   v             |
         Azure Container Apps ---- PostgreSQL <----+
                 |
                 |
          Monitoring / Logs
                 |
        +--------+--------+
        |                 |
   Azure Monitor     Log Analytics
        |
 Application Insights
```

---

# Application Flow

```text
Client
  |
  v
HTTPS Request
  |
  v
Azure Container Apps
  |
  v
Express Application
  |
  +--------------------+
  |                    |
  v                    v
Authentication       Request Validation
  |                    |
  +---------+----------+
            |
            v
       Business Logic
            |
            v
       PostgreSQL
            |
            v
       HTTP Response
```

---

# Health and Readiness Flow

The application exposes separate health and readiness checks.

```text
Container Starts
      |
      v
Application Starts
      |
      v
   /health
      |
      +---- Application Process Healthy
      |
      v
    /ready
      |
      v
PostgreSQL Connection Check
      |
      +---- Database Connected
      |
      v
Application Ready
```

This separation allows the container platform to distinguish between:

- Application process health
- Application readiness
- Database connectivity

---

# DevOps Flow

```text
Developer
    |
    v
Git Commit
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    +----------------------+
    |                      |
    v                      v
Application Validation   Security Scan
    |                      |
    v                      v
Docker Build            Trivy
    |                      |
    +----------+-----------+
               |
               v
        Terraform Validation
               |
               v
        Deployment Pipeline
               |
               v
       Azure Container Registry
               |
               v
       Azure Container Apps
               |
               v
           Production
```

> The Azure deployment stages above represent the implemented target deployment architecture. They were not executed against a live Azure subscription during this assessment.

---

# Technology Stack

## Application

- Node.js
- Express
- PostgreSQL
- JWT
- JavaScript

## DevOps

- Docker
- Docker Compose
- Terraform
- Git
- GitHub
- GitHub Actions

## Azure

- Azure Resource Group
- Azure Virtual Network
- Azure Subnets
- Network Security Groups
- Azure Container Registry
- Azure Container Apps
- Azure Database for PostgreSQL Flexible Server
- Azure Key Vault
- Managed Identity
- Azure RBAC
- Private DNS
- Azure Monitor
- Log Analytics
- Application Insights

## Security

- JWT authentication
- Parameterized SQL queries
- Environment-based configuration
- Non-root container
- Multi-stage Docker build
- Runtime npm removal
- Trivy
- Azure Key Vault
- Managed Identity
- RBAC
- GitHub OIDC

---

# Repository Structure

```text
devops-assessment/
│
├── .github/
│   ├── CODEOWNERS
│   └── workflows/
│       ├── ci.yml
│       ├── deploy.yml
│       └── security.yml
│
├── config/
│   └── db.js
│
├── middleware/
│   └── auth.js
│
├── docs/
│   ├── ARCHITECTURE.md
│   ├── COST.md
│   ├── DECISIONS.md
│   ├── DEPLOYMENT.md
│   ├── REPORT.md
│   ├── REVIEW.md
│   ├── RUNBOOK.md
│   ├── SECURITY.md
│   ├── TODO.md
│   └── images/
│       ├── 01-project-structure.png
│       ├── 02-application-syntax-check.png
│       ├── 03-docker-compose-healthy.png
│       ├── 04-health-endpoint.png
│       ├── 05-readiness-database.png
│       ├── 06-terraform-validation.png
│       ├── 07-git-diff-check.png
│       ├── 08-trivy-security-scan.png
│       ├── 09-container-hardening.png
│       └── 10-final-validation.png
│
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   │   └── terraform.tfvars
│   │   ├── stage/
│   │   │   └── terraform.tfvars
│   │   └── prod/
│   │       └── terraform.tfvars
│   │
│   ├── acr.tf
│   ├── alerts.tf
│   ├── backend.tf
│   ├── container-app.tf
│   ├── identity.tf
│   ├── keyvault.tf
│   ├── locals.tf
│   ├── log-analytics.tf
│   ├── monitoring.tf
│   ├── network.tf
│   ├── nsg.tf
│   ├── outputs.tf
│   ├── postgres.tf
│   ├── providers.tf
│   ├── rbac.tf
│   ├── resource-group.tf
│   ├── terraform.tfvars.example
│   ├── variables.tf
│   └── versions.tf
│
├── Dockerfile
├── docker-compose.yml
├── package.json
├── package-lock.json
├── schema.sql
├── server.js
└── README.md
```

---

# Application

The backend is implemented using Node.js and Express.

The application uses PostgreSQL as its persistent data store.

Database connections are managed through PostgreSQL connection pooling.

Connection pooling avoids creating a new database connection for every request and improves application efficiency.

The application also externalizes environment-specific configuration rather than hardcoding it into source code.

---

# API Endpoints

The application includes endpoints for:

## Health

```text
GET /health
```

Used to determine whether the application process is running.

## Readiness

```text
GET /ready
```

Used to determine whether the application can communicate with PostgreSQL.

## Authentication

Authentication APIs are used to obtain JWT credentials.

## Fleet APIs

Fleet-related APIs handle vehicle and telemetry operations.

## Administration

Protected administrative endpoints require JWT authentication.

---

# Health and Readiness

## Health Response

```json
{
  "status": "UP",
  "service": "fleet-ping-service",
  "timestamp": "..."
}
```

## Readiness Response

```json
{
  "status": "READY",
  "database": "connected"
}
```

The readiness endpoint verifies database connectivity before the application is considered ready.

---

# Docker Implementation

The application uses a multi-stage Docker build.

## Build Stage

The builder stage:

- Uses Node.js Alpine
- Installs production dependencies
- Copies application source
- Creates the application filesystem

## Runtime Stage

The runtime stage:

- Uses a Node.js Alpine runtime
- Copies the application from the builder stage
- Creates a dedicated application user
- Removes npm from the runtime image
- Runs the application as a non-root user

Conceptually:

```text
Node.js Base Image
       |
       v
   Builder Stage
       |
       +-- npm ci
       +-- Application Files
       |
       v
   Runtime Stage
       |
       +-- Application
       +-- Production Dependencies
       +-- Non-root User
       |
       v
   Fleet Ping Service
```

---

# Docker Compose

Docker Compose provides the local application environment.

```text
Docker Compose
      |
      +------------------+
      |                  |
      v                  v
Fleet Ping App       PostgreSQL
      |                  |
      +--------+---------+
               |
               v
        Docker Network
```

The application communicates with PostgreSQL using the Docker Compose service name rather than `localhost`.

This makes the local architecture closer to a containerized production environment.

---

# Container Security

The final runtime image was hardened to reduce its attack surface.

Implemented controls include:

- Multi-stage Docker build
- Alpine-based runtime
- Non-root user
- npm removed from runtime image
- Docker health check
- Production dependency installation
- Reduced runtime contents

The runtime container was explicitly verified to run as a dedicated application user.

The runtime image was also verified to no longer contain the `npm` executable.

---

# Terraform Infrastructure

Infrastructure is defined using Terraform.

The Terraform configuration includes:

```text
Resource Group
     |
     v
Virtual Network
     |
     +----------------------+
     |                      |
     v                      v
Container Apps Subnet   PostgreSQL Subnet
     |                      |
     v                      v
Container Apps          PostgreSQL
     |
     +-------------------+
     |                   |
     v                   v
ACR                 Key Vault
     |
     v
Managed Identity
     |
     v
Azure RBAC
```

Terraform resources include:

- Resource Group
- Virtual Network
- Subnets
- Network Security Groups
- Azure Container Registry
- Azure Container Apps Environment
- Azure Container App
- PostgreSQL Flexible Server
- PostgreSQL database
- Private DNS
- Azure Key Vault
- Managed Identity
- RBAC assignments
- Log Analytics
- Azure Monitor
- Alert rules

---

# Environment Strategy

Three environment configurations are provided:

```text
terraform/environments/

├── dev/
│   └── terraform.tfvars
│
├── stage/
│   └── terraform.tfvars
│
└── prod/
    └── terraform.tfvars
```

The same Terraform architecture can therefore support:

```text
Development
    |
    v
Staging
    |
    v
Production
```

Example validation command:

```bash
terraform -chdir=terraform plan \
  -var-file=environments/dev/terraform.tfvars
```

Environment-specific values are separated from the reusable Terraform resource definitions.

---

# Terraform Validation

Terraform formatting and validation were executed locally.

```bash
terraform -chdir=terraform fmt -check -recursive

terraform -chdir=terraform validate
```

Validation result:

```text
Success! The configuration is valid.
```

No live Azure apply was performed.

---

# Azure Architecture

The target Azure architecture uses managed services.

## Azure Container Apps

Hosts the containerized Fleet Ping application.

Responsibilities include:

- Container execution
- HTTPS ingress
- Health monitoring
- Revision management
- Scaling

## Azure Container Registry

Stores application container images.

Intended deployment flow:

```text
GitHub Actions
      |
      v
Docker Build
      |
      v
Azure Container Registry
      |
      v
Azure Container Apps
```

## PostgreSQL Flexible Server

Provides managed PostgreSQL storage.

The Terraform architecture separates application and database networking.

## Azure Key Vault

Stores sensitive configuration such as:

- PostgreSQL password
- JWT secret

## Managed Identity

The application infrastructure is designed to use Azure Managed Identity instead of embedding long-lived Azure credentials.

## RBAC

Azure RBAC is used to control access to:

- Azure Container Registry
- Azure Key Vault
- Other Azure resources

---

# Security Architecture

Security is implemented at multiple layers.

```text
                 Internet
                    |
                    v
                  HTTPS
                    |
                    v
          Azure Container Apps
                    |
                    v
          JWT Authentication
                    |
                    v
           Express Application
              /          \
             /            \
            v              v
      Key Vault       PostgreSQL
            |              |
            +------+-------+
                   |
                   v
             Azure Identity
                   |
                   v
                  RBAC
```

---

# Application Security

## JWT Authentication

Protected APIs require valid JWT credentials.

## Parameterized SQL

SQL queries use parameters rather than directly concatenating user input.

Example:

```sql
SELECT * FROM drivers WHERE phone = $1;
```

This separates user input from the SQL statement and reduces SQL injection risk.

## Environment Configuration

Sensitive configuration is externalized from application source code.

Examples include:

```text
DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
JWT_SECRET
```

## Request Validation

Incoming requests are validated before business logic is executed.

---

# Secrets Management

Production secrets are designed to be stored in Azure Key Vault.

Examples:

```text
postgres-password
jwt-secret
```

Target flow:

```text
Azure Key Vault
      |
      v
Managed Identity
      |
      v
Azure RBAC
      |
      v
Container Application
```

No production secret should be committed to Git.

Local development uses environment configuration.

---

# CI/CD

GitHub Actions workflows are included under:

```text
.github/workflows/

├── ci.yml
├── deploy.yml
└── security.yml
```

---

# CI Pipeline

The CI workflow is designed to validate the application and infrastructure.

Typical flow:

```text
Git Push
   |
   v
GitHub Actions
   |
   +--> Node.js Validation
   |
   +--> Docker Build
   |
   +--> Terraform Format
   |
   +--> Terraform Validate
   |
   v
Validation Complete
```

---

# Security Pipeline

The security workflow includes Trivy-based container scanning.

```text
Docker Image
      |
      v
    Trivy
      |
      +---- Vulnerability Scan
      |
      +---- Security Result
```

---

# Deployment Pipeline

The target deployment workflow is:

```text
Git Push
   |
   v
GitHub Actions
   |
   v
Build Container
   |
   v
Trivy Scan
   |
   v
Push Image to ACR
   |
   v
Azure Authentication
   |
   v
Terraform
   |
   v
Azure Container Apps
```

Because an Azure subscription was not available, the final Azure deployment stages were not executed against live Azure resources.

---

# GitHub OIDC

The deployment architecture is designed to use GitHub OpenID Connect with Azure.

The objective is to avoid storing long-lived Azure credentials inside GitHub Actions.

Conceptually:

```text
GitHub Actions
      |
      v
GitHub OIDC Token
      |
      v
Azure Identity
      |
      v
Azure Resources
```

This provides a more secure authentication model for CI/CD.

---

# Security Scanning

Trivy was used to scan the final Docker image.

Command:

```bash
trivy image \
  --scanners vuln \
  --severity HIGH,CRITICAL \
  devops-assessment-app:latest
```

Final scan result:

```text
Total: 0 (HIGH: 0, CRITICAL: 0)
```

An earlier scan identified vulnerabilities in packages bundled with npm inside the Node.js runtime image, including:

```text
tar
brace-expansion
ip-address
picomatch
sigstore
```

Investigation showed that these packages were not application dependencies.

They were part of npm installed inside the Node.js runtime image.

The Dockerfile was hardened by removing npm from the runtime stage because the running Node.js application does not require npm.

The final runtime image was then rebuilt and scanned again.

Result:

```text
HIGH: 0
CRITICAL: 0
```

This reduced the final runtime vulnerability surface.

---

# Testing and Validation

The project was validated using several independent checks.

---

## Node.js Syntax Validation

Command:

```bash
npm test
```

The test command validates:

```text
server.js
config/db.js
middleware/auth.js
```

---

## Docker Validation

Command:

```bash
docker compose up -d --build
```

Then:

```bash
docker compose ps
```

Both application and PostgreSQL containers were verified as healthy.

---

## Health Validation

Command:

```bash
curl -i --max-time 10 http://localhost:3000/health
```

Expected:

```text
HTTP/1.1 200 OK
```

Example response:

```json
{
  "status": "UP",
  "service": "fleet-ping-service",
  "timestamp": "..."
}
```

---

## Readiness Validation

Command:

```bash
curl -i --max-time 10 http://localhost:3000/ready
```

Expected:

```text
HTTP/1.1 200 OK
```

Example:

```json
{
  "status": "READY",
  "database": "connected"
}
```

---

## Terraform Validation

Commands:

```bash
terraform -chdir=terraform fmt -check -recursive

terraform -chdir=terraform validate
```

Result:

```text
Success! The configuration is valid.
```

---

## Git Validation

Command:

```bash
git diff --check
```

Result:

```text
No errors
```

---

# Monitoring and Observability

The target Azure implementation includes:

- Azure Monitor
- Log Analytics
- Application Insights
- Alert rules

Monitoring objectives include:

- Application availability
- Container health
- Error rates
- Response times
- Database connectivity
- Container restarts
- Resource utilization

Operational flow:

```text
Application
    |
    v
Container Apps
    |
    +--------------------+
    |                    |
    v                    v
Log Analytics      Application Insights
    |                    |
    +---------+----------+
              |
              v
        Azure Monitor
              |
              v
           Alerts
```

---

# Cost Optimization

The architecture is designed with development cost awareness.

Primary cost drivers include:

- PostgreSQL Flexible Server
- Container Apps compute
- Log Analytics ingestion
- Application Insights telemetry
- Container Registry

Development optimization strategies include:

- Burstable PostgreSQL SKU
- Container Apps scale-to-zero where appropriate
- Right-sized CPU and memory
- Log retention control
- Telemetry sampling
- Container image cleanup
- Destroying unused Terraform environments

Detailed cost considerations are documented in:

```text
docs/COST.md
```

---

# Deployment Status

## Locally Validated

The following components were successfully validated locally:

- Node.js application
- PostgreSQL
- Docker
- Docker Compose
- Health endpoint
- Readiness endpoint
- Terraform formatting
- Terraform validation
- Git validation
- Trivy vulnerability scanning
- Multi-stage Docker build
- Non-root container
- npm removal from runtime image
- Environment configuration
- Repository structure

---

## Implemented as Code but Not Live-Deployed

The following Azure components are represented in the Terraform and CI/CD implementation but were not provisioned in a live Azure subscription:

- Azure Resource Group
- Azure Virtual Network
- Azure Subnets
- Network Security Groups
- Azure Container Registry
- Azure Container Apps
- PostgreSQL Flexible Server
- Azure Key Vault
- Managed Identity
- Azure RBAC
- Log Analytics
- Azure Monitor
- Application Insights
- Azure deployment through GitHub Actions

---

# Why Azure Was Not Deployed

A live Azure subscription was not available during implementation.

Therefore, no claim is made that these Azure resources were actually deployed.

This project intentionally distinguishes between:

```text
Implemented as Code
        |
        v
Validated Locally
        |
        X
No Live Azure Apply
```

This makes the assessment reproducible and avoids representing unperformed cloud operations as completed.

---

# AI Assistance

AI assistance was used as a development and documentation aid during the project.

## AI Tool

**ChatGPT**

AI assistance was used for:

- DevOps architecture discussion
- Terraform structure review
- Docker hardening analysis
- CI/CD workflow design
- Documentation structure
- Troubleshooting
- Security-review reasoning
- README preparation
- Engineering decision explanations
- Interview-oriented project explanation

AI was used as an engineering assistant.

The actual implementation commands, local application testing, Docker builds, Terraform validation, Git validation, and security scanning were executed and verified in the local development environment.

## Security Tool

**Trivy**

Trivy is **not an AI tool**.

It was used specifically for:

- Container vulnerability scanning
- HIGH/CRITICAL vulnerability detection
- Security validation of the final Docker image

---

# Documentation

Detailed documentation is available under `docs/`.

| Document | Purpose |
|---|---|
| `ARCHITECTURE.md` | Architecture and infrastructure design |
| `COST.md` | Cost estimation and optimization |
| `DECISIONS.md` | Engineering decisions |
| `DEPLOYMENT.md` | Deployment procedures |
| `REPORT.md` | Project implementation report |
| `REVIEW.md` | Implementation review |
| `RUNBOOK.md` | Operations and troubleshooting |
| `SECURITY.md` | Security architecture |
| `TODO.md` | Future improvements |

---

# Screenshots

The following screenshots provide evidence of the locally validated implementation.

> All screenshots are stored inside the repository under [`docs/images/`](docs/images/).

---

## 1. Project Structure

Shows the project organization, application code, Terraform infrastructure, CI/CD workflows, and documentation.

![Project Structure](docs/images/01-project-structure.png)

---

## 2. Application Syntax Validation

Node.js application files were syntax-checked using the project's test command.

![Application Syntax Validation](docs/images/02-application-syntax-check.png)

---

## 3. Docker Compose Health

Both the Fleet Ping application and PostgreSQL containers are running successfully and report healthy status.

![Docker Compose Health](docs/images/03-docker-compose-healthy.png)

---

## 4. Application Health Endpoint

The application successfully returns HTTP 200 from the `/health` endpoint.

![Application Health Endpoint](docs/images/04-health-endpoint.png)

---

## 5. Database Readiness

The `/ready` endpoint confirms that the application can successfully connect to PostgreSQL.

![Database Readiness](docs/images/05-readiness-database.png)

---

## 6. Terraform Validation

Terraform formatting and configuration validation were successfully completed.

![Terraform Validation](docs/images/06-terraform-validation.png)

---

## 7. Git Validation

Git whitespace validation completed without errors.

![Git Validation](docs/images/07-git-diff-check.png)

---

## 8. Trivy Security Scan

The final hardened Docker image was scanned using Trivy.

Final result:

```text
Total: 0 (HIGH: 0, CRITICAL: 0)
```

![Trivy Security Scan](docs/images/08-trivy-security-scan.png)

---

## 9. Container Hardening

The runtime image was verified to:

- Run as a non-root application user
- Remove npm from the runtime image

![Container Hardening](docs/images/09-container-hardening.png)

---

## 10. Final Validation

The final validation combines:

- Node.js checks
- Docker health
- Health endpoint
- Readiness endpoint
- Terraform validation
- Git validation
- Trivy security scanning

![Final Validation](docs/images/10-final-validation.png)

---

# Production Roadmap

## Completed

### Application

- Environment variables
- PostgreSQL connection pooling
- Parameterized SQL
- SQL injection prevention
- Request validation
- JWT authentication
- Health endpoint
- Readiness endpoint

### Docker

- Multi-stage Docker build
- Non-root runtime
- Health check
- Runtime hardening
- npm removal from runtime image
- Docker Compose environment

### Infrastructure as Code

- Terraform project structure
- Environment separation
- Azure networking configuration
- Container Apps configuration
- PostgreSQL configuration
- ACR configuration
- Key Vault configuration
- Managed Identity configuration
- RBAC configuration
- Monitoring configuration

### CI/CD

- GitHub Actions CI
- Security workflow
- Deployment workflow
- Terraform validation
- Docker build validation
- Trivy scanning

### Documentation

- Architecture documentation
- Deployment guide
- Security guide
- Operations runbook
- Cost documentation
- Engineering decisions
- Implementation report
- Production roadmap

---

# Planned Production Enhancements

## Azure

- Live Azure deployment
- Azure Container Registry image publishing
- Azure Container Apps deployment
- Production DNS
- HTTPS domain configuration
- Private endpoints where appropriate
- Production monitoring

## CI/CD

- GitHub OIDC federation
- Protected production environment
- Deployment approvals
- Automated rollback
- Immutable SHA-based image deployment

## Security

- Microsoft Defender for Cloud
- Azure Policy
- Automated secret rotation
- Image signing
- SBOM generation
- Advanced security monitoring

## Reliability

- Autoscaling
- Database backup validation
- Disaster recovery testing
- Graceful shutdown
- Multi-region architecture where required

---

# Limitations

The current assessment implementation has the following limitations.

## No Live Azure Subscription

The Azure infrastructure could not be provisioned because a live Azure subscription was unavailable.

Therefore:

```text
Terraform Code
       |
       v
Validated Locally
       |
       X
No Live Azure Apply
```

---

## No Live ACR Push

The container image was built and scanned locally but was not pushed to a real Azure Container Registry.

---

## No Live Container Apps Deployment

The application was validated through Docker Compose locally rather than through a live Azure Container Apps environment.

---

## No Production Traffic

The application has not been tested against real production traffic or production-scale workloads.

These limitations are intentionally documented rather than hidden.

---

# What I Would Do Next

If an Azure subscription becomes available, the next implementation sequence would be:

```text
1. Configure Azure subscription
          |
          v
2. Configure Terraform remote backend
          |
          v
3. Provision development infrastructure
          |
          v
4. Create Azure Container Registry
          |
          v
5. Push immutable container image
          |
          v
6. Deploy Azure Container Apps
          |
          v
7. Configure Key Vault
          |
          v
8. Configure Managed Identity + RBAC
          |
          v
9. Configure monitoring
          |
          v
10. Configure GitHub OIDC
          |
          v
11. Test CI/CD deployment
          |
          v
12. Validate health/readiness
          |
          v
13. Configure alerts
          |
          v
14. Test rollback
```

---

# Interview Explanation

A concise explanation of the project:

> I built a production-oriented DevOps platform for a Node.js fleet-tracking application. I containerized the application using a multi-stage Docker build and ran it with PostgreSQL through Docker Compose for local development.
>
> For infrastructure, I created Terraform configurations for Azure Container Apps, Azure Container Registry, PostgreSQL Flexible Server, VNet, subnets, NSGs, Key Vault, Managed Identity, RBAC, and monitoring.
>
> I separated development, staging, and production Terraform configurations and added GitHub Actions workflows for CI, security scanning, and deployment.
>
> For security, I implemented JWT authentication, parameterized SQL queries, environment-based configuration, non-root containers, removal of npm from the runtime image, Azure Key Vault, Managed Identity, and RBAC.
>
> I also used Trivy to scan the final image. The final hardened image reported zero HIGH and CRITICAL vulnerabilities.
>
> I validated the application locally using Docker Compose, health and readiness endpoints, Terraform validation, Git checks, and container security scanning.
>
> I did not perform a live Azure deployment because an Azure subscription was not available, so I clearly separated locally validated implementation from Azure infrastructure that is implemented as code.

---

# Key Engineering Decisions

## Multi-stage Docker

Used to separate build dependencies from the runtime image and reduce the final image footprint.

## Non-root Container

Used to reduce the privileges available to the application process.

## Remove npm From Runtime

The running Node.js application does not require npm, so npm was removed from the runtime image.

This also reduced the vulnerability surface discovered during Trivy scanning.

## PostgreSQL Connection Pooling

Used to efficiently manage database connections instead of creating a new connection for every request.

## Parameterized SQL

Used to separate SQL statements from user input and reduce SQL injection risk.

## Terraform

Used to create repeatable and version-controlled infrastructure.

## Managed Identity

Used as the target Azure identity model to avoid embedding long-lived Azure credentials into the application.

## Azure Key Vault

Used as the target centralized secret-management system.

## GitHub OIDC

Used as the target authentication model for GitHub-to-Azure deployments without long-lived Azure credentials.

## Health and Readiness Separation

Used to distinguish application process health from database/application readiness.

---

# Final Project Status

| Component | Status |
|---|---|
| Application | COMPLETE |
| Docker | COMPLETE |
| Docker Compose | COMPLETE |
| Container Hardening | COMPLETE |
| PostgreSQL | COMPLETE |
| Health Checks | COMPLETE |
| Readiness Checks | COMPLETE |
| Terraform | VALIDATED |
| Environment Separation | COMPLETE |
| Trivy Security Scan | COMPLETE |
| GitHub Actions | IMPLEMENTED |
| Azure Infrastructure Code | IMPLEMENTED |
| Azure Live Deployment | NOT PERFORMED |
| Documentation | COMPLETE |
| Screenshots | COMPLETE |

---

# Validation Summary

The final local validation included:

```text
Node.js syntax validation       PASS
Docker build                    PASS
Docker Compose                  PASS
Application container           HEALTHY
PostgreSQL container            HEALTHY
/health endpoint                HTTP 200
/ready endpoint                 HTTP 200
Database connectivity           PASS
Terraform fmt                   PASS
Terraform validate              PASS
git diff --check                PASS
Trivy HIGH vulnerabilities      0
Trivy CRITICAL vulnerabilities  0
Non-root container              VERIFIED
npm runtime removal             VERIFIED
```

---

# Repository Evidence

The repository contains both implementation and supporting documentation.

```text
Application
     |
     +-- Node.js / Express
     +-- PostgreSQL
     +-- JWT
     |
     v
Containerization
     |
     +-- Dockerfile
     +-- Docker Compose
     |
     v
Infrastructure
     |
     +-- Terraform
     +-- Azure architecture
     |
     v
Security
     |
     +-- Key Vault
     +-- Managed Identity
     +-- RBAC
     +-- Trivy
     +-- Non-root container
     |
     v
CI/CD
     |
     +-- GitHub Actions
     +-- CI
     +-- Security
     +-- Deployment
     |
     v
Operations
     |
     +-- Health
     +-- Readiness
     +-- Monitoring
     +-- Runbook
     +-- Cost
     +-- Security documentation
```

---

# Author

**Bhaskar Sharma**

DevOps Engineer | AWS | Azure | Kubernetes | Terraform | CI/CD

GitHub:

https://github.com/dankbhardwaj

---

# Final Note

This project is intentionally designed as a production-oriented DevOps assessment rather than a simple application deployment.

The implementation demonstrates:

- Application engineering
- Containerization
- Container hardening
- Infrastructure as Code
- Cloud architecture
- Networking
- Identity
- Secrets management
- CI/CD
- Security scanning
- Monitoring design
- Operational readiness
- Cost awareness
- Technical documentation

The Azure portion is implemented as infrastructure and deployment code, while the locally executable portions were actually built, tested, validated, and security-scanned.

```text
                    FLEET PING SERVICE

                         Application
                              |
                              v
                         Docker
                              |
                              v
                      Docker Compose
                              |
                              v
                       PostgreSQL
                              |
                              v
                       Terraform
                              |
                              v
                    Azure Architecture
                              |
             +----------------+----------------+
             |                |                |
             v                v                v
          ACR          Container Apps      PostgreSQL
             |                |                |
             +----------------+----------------+
                              |
                              v
                         Key Vault
                              |
                              v
                      Managed Identity
                              |
                              v
                           RBAC
                              |
                              v
                       GitHub Actions
                              |
                              v
                         Trivy Scan
                              |
                              v
                    Production-Ready Design
```