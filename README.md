# VexarDrive Fleet Ping Service

Production-oriented DevOps platform for a containerized fleet-tracking backend.

This project demonstrates how a Node.js + PostgreSQL application can be developed locally, containerized, secured, validated, scanned, and prepared for deployment to Microsoft Azure using Infrastructure as Code and CI/CD practices.

> **Assessment / Deployment Note**
>
> The Azure infrastructure and deployment workflows are implemented as Terraform and GitHub Actions configuration.
>
> A live Azure subscription was not available during implementation, so live Azure provisioning and deployment were not performed.
>
> All locally testable components were implemented and validated locally, including the application, PostgreSQL, Docker, Docker Compose, Terraform validation, Git validation, container hardening, and Trivy security scanning.
>
> This README clearly distinguishes between **implemented as code** and **actually deployed**.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Problem Statement](#problem-statement)
- [Project Objectives](#project-objectives)
- [What This Project Demonstrates](#what-this-project-demonstrates)
- [Architecture](#architecture)
- [Application Flow](#application-flow)
- [Health and Readiness Flow](#health-and-readiness-flow)
- [DevOps Flow](#devops-flow)
- [Technology Stack](#technology-stack)
- [Repository Structure](#repository-structure)
- [Application](#application)
- [API Endpoints](#api-endpoints)
- [Database](#database)
- [Docker Implementation](#docker-implementation)
- [Docker Compose](#docker-compose)
- [Container Security](#container-security)
- [Terraform Infrastructure](#terraform-infrastructure)
- [Terraform Environment Strategy](#terraform-environment-strategy)
- [Azure Architecture](#azure-architecture)
- [Security Architecture](#security-architecture)
- [Application Security](#application-security)
- [Secrets Management](#secrets-management)
- [CI/CD](#cicd)
- [GitHub OIDC](#github-oidc)
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

Fleet Ping Service is a backend service designed for a fleet-tracking platform.

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
- Azure Container Apps configuration
- Azure Container Registry configuration
- Azure Database for PostgreSQL Flexible Server configuration
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
- Production-oriented documentation

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
- Rollback and recovery planning

This project demonstrates how these requirements can be addressed using modern DevOps and cloud-native practices.

---

# Project Objectives

The main objectives of the project are:

1. Containerize the Node.js application.
2. Run the application and PostgreSQL locally using Docker Compose.
3. Harden the runtime container.
4. Implement health and readiness endpoints.
5. Use PostgreSQL connection pooling.
6. Prevent SQL injection using parameterized queries.
7. Externalize environment-specific configuration.
8. Define Azure infrastructure using Terraform.
9. Separate development, staging, and production configuration.
10. Design secure secret management using Azure Key Vault.
11. Use Managed Identity and Azure RBAC.
12. Implement CI/CD workflows using GitHub Actions.
13. Add container vulnerability scanning using Trivy.
14. Document deployment, security, operations, cost, and architecture.
15. Validate all locally testable components before considering the project complete.

---

# What This Project Demonstrates

| Engineering Area | Implementation |
|---|---|
| Application | Node.js + Express |
| Database | PostgreSQL |
| Authentication | JWT |
| Containerization | Docker |
| Local Orchestration | Docker Compose |
| Infrastructure as Code | Terraform |
| Cloud Platform | Microsoft Azure |
| Container Platform | Azure Container Apps |
| Image Registry | Azure Container Registry |
| Database Platform | Azure Database for PostgreSQL Flexible Server |
| Networking | Azure VNet + Subnets + NSGs |
| Secrets | Azure Key Vault |
| Identity | Managed Identity |
| Authorization | Azure RBAC |
| CI/CD | GitHub Actions |
| CI/CD Authentication | GitHub OIDC |
| Security Scanning | Trivy |
| Monitoring | Azure Monitor |
| Logging | Log Analytics |
| Application Telemetry | Application Insights |
| Configuration | Environment Variables |
| Documentation | Markdown |

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
                 v                   |             |
                ACR                  |       Managed Identity
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

The architecture is designed around managed Azure services while keeping infrastructure reproducible through Terraform.

Application Flow
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

The application separates authentication, request validation, business logic, and database operations.

Health and Readiness Flow

The application exposes separate health and readiness endpoints.

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

This separation allows an orchestration platform to distinguish between:

Application process health
Application readiness
Database connectivity
DevOps Flow

The intended DevOps flow is:

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

Because an Azure subscription was not available, the Azure deployment portion was not executed against live infrastructure.

The CI/CD configuration remains implemented as code.

Technology Stack
Application
Node.js
Express
PostgreSQL
JWT
JavaScript
DevOps
Docker
Docker Compose
Terraform
Git
GitHub
GitHub Actions
Azure
Azure Resource Group
Azure Virtual Network
Azure Subnets
Network Security Groups
Azure Container Registry
Azure Container Apps
Azure Database for PostgreSQL Flexible Server
Azure Key Vault
Managed Identity
Azure RBAC
Private DNS
Azure Monitor
Log Analytics
Application Insights
Security
JWT authentication
Parameterized SQL
Environment-based configuration
Non-root container
Multi-stage Docker build
Trivy
Azure Key Vault
Managed Identity
Azure RBAC
GitHub OIDC
Repository Structure
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
Application

The backend is implemented using Node.js and Express.

The application uses PostgreSQL as its persistent data store.

Database connections are managed through PostgreSQL connection pooling.

Using a connection pool avoids creating a new database connection for every request and improves application efficiency.

The application also validates required environment variables before starting.

API Endpoints

The application includes endpoints for:

Health
GET /health

Used to determine whether the application process is running.

Readiness
GET /ready

Used to determine whether the application can communicate with PostgreSQL.

Authentication

Authentication APIs are used to obtain JWT credentials.

Fleet APIs

Fleet-related APIs handle vehicle and telemetry operations.

Administration

Protected administrative endpoints require JWT authentication.

Health and Readiness
Health Response
{
  "status": "UP",
  "service": "fleet-ping-service",
  "timestamp": "..."
}
Readiness Response
{
  "status": "READY",
  "database": "connected"
}

The readiness endpoint verifies database connectivity before the application is considered ready.

Database

PostgreSQL is used as the application's relational database.

The local environment uses:

PostgreSQL 15 Alpine

The production target architecture uses:

Azure Database for PostgreSQL Flexible Server

The application uses connection pooling.

Example architecture:

Fleet Ping Application
        |
        v
   pg.Pool
        |
        v
   PostgreSQL

The database schema is initialized automatically in the Docker Compose environment.

Docker Implementation

The application uses a multi-stage Docker build.

Build Stage

The builder stage:

Uses Node.js Alpine
Installs production dependencies
Copies application source
Prepares the application runtime
Runtime Stage

The runtime stage:

Uses a Node.js Alpine base
Copies the required application files
Creates a dedicated application user
Removes npm from the runtime image
Runs the application as a non-root user

Conceptually:

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
Docker Compose

Docker Compose provides the local application environment.

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

The application communicates with PostgreSQL using the Docker Compose service name instead of localhost.

Example:

DB_HOST=db

This reflects how containerized services communicate in a networked environment.

Container Security

The final runtime image was hardened to reduce unnecessary attack surface.

Implemented controls include:

Multi-stage Docker build
Alpine-based runtime
Non-root user
npm removed from runtime image
Docker health check
Production dependency installation
Reduced runtime contents

The runtime container was verified to run using a dedicated application user.

The runtime image was also verified to no longer contain npm.

This is important because npm is not required to execute the production Node.js application.

Terraform Infrastructure

Infrastructure is defined using Terraform.

The Terraform configuration includes:

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

Terraform resources include:

Resource Group
Virtual Network
Subnets
Network Security Groups
Azure Container Registry
Azure Container Apps Environment
Azure Container App
PostgreSQL Flexible Server
PostgreSQL database
Private DNS
Azure Key Vault
Managed Identity
RBAC assignments
Log Analytics
Azure Monitor
Alert rules
Terraform Environment Strategy

The repository contains separate environment configurations:

terraform/environments/

├── dev/
│   └── terraform.tfvars
│
├── stage/
│   └── terraform.tfvars
│
└── prod/
    └── terraform.tfvars

This allows the same Terraform architecture to support different environments.

Example:

terraform -chdir=terraform plan \
  -var-file=environments/dev/terraform.tfvars

The environment-specific configuration controls values such as:

Environment name
Project name
Azure region
PostgreSQL administrator username
Subscription configuration
Alert configuration

No real Azure credentials or secrets are stored in the repository.

Terraform Validation

Terraform formatting and validation were executed locally.

terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform validate

Validation result:

Success! The configuration is valid.

No live Terraform apply was performed because an Azure subscription was not available.

Azure Architecture

The target Azure architecture uses managed services.

Azure Container Apps

Azure Container Apps is intended to host the containerized Fleet Ping application.

Responsibilities include:

Container execution
HTTPS ingress
Health monitoring
Revision management
Scaling
Azure Container Registry

Azure Container Registry is intended to store application container images.

Target deployment flow:

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
PostgreSQL Flexible Server

Azure Database for PostgreSQL Flexible Server is the target managed database platform.

The Terraform architecture separates application and database networking.

Azure Key Vault

Azure Key Vault is intended to store sensitive configuration such as:

PostgreSQL password
JWT secret
Managed Identity

Managed Identity is used as the target Azure-native identity mechanism.

The purpose is to avoid embedding long-lived Azure credentials into application or deployment configuration.

Azure RBAC

Azure RBAC is used to control access to:

Azure Container Registry
Azure Key Vault
Other Azure resources
Security Architecture

Security is implemented across multiple layers.

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

The architecture follows layered security principles.

Application Security
JWT Authentication

Protected APIs require valid JWT credentials.

Example:

Authorization: Bearer <JWT_TOKEN>

Invalid or missing credentials result in unauthorized access.

Parameterized SQL

SQL queries use parameters rather than directly concatenating user input.

Example:

SELECT * FROM drivers WHERE phone = $1;

This separates SQL instructions from user-controlled values and reduces SQL injection risk.

Environment Configuration

Sensitive configuration is externalized from application source code.

Examples include:

DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
JWT_SECRET
Request Validation

Incoming requests are validated before business logic is executed.

This improves:

API reliability
Input handling
Application stability
Security posture
Secrets Management

Production secrets are designed to be stored in Azure Key Vault.

Examples include:

postgres-password
jwt-secret

Target architecture:

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

No production secret should be committed to Git.

For local development, environment files are used and excluded from version control.

CI/CD

GitHub Actions workflows are included for:

.github/workflows/

├── ci.yml
├── deploy.yml
└── security.yml
CI Pipeline

The CI workflow is designed to validate the application and infrastructure.

Typical flow:

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
Security Pipeline

The security workflow includes Trivy-based container scanning.

Docker Image
      |
      v
    Trivy
      |
      +---- Vulnerability Scan
      |
      +---- Security Result
Deployment Pipeline

The deployment workflow is designed for Azure deployment.

Target flow:

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

The workflow is implemented as code but was not executed against live Azure infrastructure.

GitHub OIDC

The deployment architecture is designed to use GitHub OpenID Connect with Azure.

The objective is to avoid storing long-lived Azure credentials inside GitHub Actions.

Conceptually:

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

This provides a more secure authentication model for CI/CD.

Because there was no Azure subscription available, the live federation and deployment were not performed.

Security Scanning

Trivy was used to scan the final Docker image.

Command:

trivy image \
  --scanners vuln \
  --severity HIGH,CRITICAL \
  devops-assessment-app:latest

The final hardened runtime image produced:

Total: 0 (HIGH: 0, CRITICAL: 0)

The earlier scan identified vulnerabilities in packages bundled with npm inside the Node.js runtime image.

Examples included:

tar
brace-expansion
ip-address
picomatch
sigstore

Investigation showed these were not application dependencies.

They were part of npm's bundled dependency tree inside the Node.js runtime image.

The Dockerfile was therefore hardened by removing npm from the runtime stage.

After rebuilding the image, the final HIGH/CRITICAL vulnerability scan returned:

Total: 0 (HIGH: 0, CRITICAL: 0)

This demonstrates a practical container-hardening workflow:

Initial Scan
     |
     v
Identify Vulnerabilities
     |
     v
Determine Dependency Origin
     |
     v
Remove Unnecessary Runtime Component
     |
     v
Rebuild Image
     |
     v
Rescan
     |
     v
0 HIGH / CRITICAL
Testing and Validation

The project was validated using several independent checks.

Node.js Syntax Validation

Command:

npm test

The test command validates:

server.js
config/db.js
middleware/auth.js

The command completed successfully.

Docker Validation

Command:

docker compose up -d --build

Then:

docker compose ps

The application and PostgreSQL containers were verified as healthy.

Expected result:

fleet-ping-app    healthy
fleet-ping-db     healthy
Health Validation

Command:

curl -i --max-time 10 http://localhost:3000/health

Expected:

HTTP/1.1 200 OK

Example response:

{
  "status": "UP",
  "service": "fleet-ping-service",
  "timestamp": "..."
}
Readiness Validation

Command:

curl -i --max-time 10 http://localhost:3000/ready

Expected:

HTTP/1.1 200 OK

Example:

{
  "status": "READY",
  "database": "connected"
}

This confirms that the application can communicate with PostgreSQL.

Terraform Validation

Commands:

terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform validate

Result:

Success! The configuration is valid.
Git Validation

Command:

git diff --check

Result:

No whitespace errors
Final Validation

The final validation sequence used:

npm test

docker compose ps

curl -i --max-time 10 http://localhost:3000/health

curl -i --max-time 10 http://localhost:3000/ready

terraform -chdir=terraform fmt -check -recursive

terraform -chdir=terraform validate

git diff --check

The locally testable project components completed successfully.

Monitoring and Observability

The target Azure implementation includes:

Azure Monitor
Log Analytics
Application Insights
Alert rules

Monitoring objectives include:

Application availability
Container health
Error rates
Response times
Database connectivity
Container restarts
Resource utilization

Operational flow:

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

These components are represented in Terraform but were not provisioned in a live Azure environment.

Cost Optimization

The architecture was designed with development cost awareness.

Primary potential cost drivers include:

PostgreSQL Flexible Server
Container Apps compute
Log Analytics ingestion
Application Insights telemetry
Container Registry

Development optimization strategies include:

Burstable PostgreSQL SKU
Scale-to-zero where appropriate
Right-sized CPU and memory
Log retention control
Telemetry sampling
Container image cleanup
Destroying unused Terraform environments

Detailed cost considerations are documented in:

docs/COST.md
Deployment Status
Locally Validated

The following components were successfully validated locally:

Node.js application
PostgreSQL
Docker
Docker Compose
Health endpoint
Readiness endpoint
Terraform formatting
Terraform validation
Git validation
Trivy vulnerability scanning
Multi-stage Docker build
Non-root container
npm removal from runtime image
Environment configuration
Repository structure
Implemented as Code but Not Live-Deployed

The following Azure components are represented in Terraform and CI/CD configuration but were not provisioned in a live Azure subscription:

Azure Resource Group
Azure Virtual Network
Azure Subnets
Network Security Groups
Azure Container Registry
Azure Container Apps
PostgreSQL Flexible Server
Azure Key Vault
Managed Identity
Azure RBAC
Log Analytics
Azure Monitor
Application Insights
Azure deployment through GitHub Actions
Why Was Azure Not Deployed?

A live Azure subscription was not available during implementation.

Therefore, this project does not claim that Azure infrastructure was actually deployed.

The project intentionally distinguishes between:

Implemented as Code
        |
        v
Validated Locally
        |
        X
Live Azure Deployment

This distinction is important for technical accuracy.

AI Assistance

AI assistance was used as a development and documentation aid during the project.

AI Tool

ChatGPT

AI assistance was used for:

DevOps architecture discussion
Terraform structure review
Docker hardening analysis
CI/CD workflow design
Documentation structure
Troubleshooting
Security-review reasoning
README preparation
Engineering decision explanation
Interview-oriented project explanation

AI was used as an engineering assistant.

Implementation commands, local testing, Docker builds, Terraform validation, container hardening, and security scanning were executed and verified in the local development environment.

Security Tool

Trivy

Trivy is not an AI tool.

It was used specifically for:

Container vulnerability scanning
HIGH/CRITICAL vulnerability detection
Security validation of the final Docker image
Documentation

Detailed documentation is available under docs/.

Document	Purpose
ARCHITECTURE.md	Architecture and infrastructure design
COST.md	Cost estimation and optimization
DECISIONS.md	Engineering decisions
DEPLOYMENT.md	Deployment procedures
REPORT.md	Project implementation report
REVIEW.md	Implementation review
RUNBOOK.md	Operations and troubleshooting
SECURITY.md	Security architecture
TODO.md	Future improvements
Screenshots

The following screenshots provide evidence of the locally validated implementation.

1. Project Structure

Shows the project organization, application code, Terraform infrastructure, CI/CD workflows, and documentation.

2. Application Syntax Validation

Node.js application files were syntax-checked using the project's test command.

3. Docker Compose Health

Both the Fleet Ping application and PostgreSQL containers are running successfully and report healthy status.

4. Application Health Endpoint

The application successfully returns HTTP 200 from the /health endpoint.

5. Database Readiness

The /ready endpoint confirms that the application can successfully connect to PostgreSQL.

6. Terraform Validation

Terraform formatting and configuration validation were successfully completed.

7. Git Validation

Git whitespace validation completed without errors.

8. Trivy Security Scan

The final hardened Docker image was scanned using Trivy.

Result:

Total: 0 (HIGH: 0, CRITICAL: 0)

9. Container Hardening

The runtime image was verified to:

Run as a non-root user
Remove npm from the runtime image

10. Final Validation

The final validation combines:

Node.js checks
Docker health
Health endpoint
Readiness endpoint
Terraform validation
Git validation
Trivy security scanning

Production Roadmap
Completed
Application
Environment variables
PostgreSQL connection pooling
Parameterized SQL
Request validation
JWT authentication
Health endpoint
Readiness endpoint
Docker
Multi-stage build
Non-root runtime
Health check
Runtime hardening
npm removal from runtime image
Docker Compose environment
Infrastructure as Code
Terraform project structure
Environment separation
Azure networking configuration
Container Apps configuration
PostgreSQL configuration
ACR configuration
Key Vault configuration
Managed Identity configuration
RBAC configuration
Monitoring configuration
CI/CD
GitHub Actions CI
Security workflow
Deployment workflow
Terraform validation
Docker build validation
Trivy scanning
Documentation
Architecture documentation
Deployment guide
Security guide
Operations runbook
Cost documentation
Engineering decisions
Implementation report
Production roadmap
Planned Production Enhancements
Azure
Live Azure deployment
Azure Container Registry image publishing
Azure Container Apps deployment
Production DNS
HTTPS domain configuration
Private endpoints where appropriate
Production monitoring
CI/CD
GitHub OIDC federation with live Azure
Protected production environment
Deployment approvals
Automated rollback
Immutable SHA-based image deployment
Security
Microsoft Defender for Cloud
Azure Policy
Automated secret rotation
Image signing
SBOM generation
Advanced security monitoring
Reliability
Autoscaling
Database backup validation
Disaster recovery testing
Graceful shutdown
Multi-region architecture where required
Limitations

The current assessment implementation has the following limitations.

No Live Azure Subscription

The Azure infrastructure could not be provisioned because a live Azure subscription was unavailable.

Therefore:

Terraform
    |
    v
Validated Locally
    |
    X
No Live Azure Apply
No Live ACR Push

The container image was built and scanned locally but was not pushed to a real Azure Container Registry.

No Live Container Apps Deployment

The application was validated through Docker Compose locally rather than through a live Azure Container Apps environment.

No Production Traffic

The application has not been tested against real production traffic or production-scale workloads.

These limitations are intentionally documented rather than hidden.

What I Would Do Next

If an Azure subscription becomes available, the next implementation sequence would be:

1. Configure Azure Subscription
          |
          v
2. Configure Terraform Remote Backend
          |
          v
3. Provision Development Infrastructure
          |
          v
4. Create Azure Container Registry
          |
          v
5. Build and Push Immutable Container Image
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
9. Configure Monitoring
          |
          v
10. Configure GitHub OIDC
          |
          v
11. Test CI/CD Deployment
          |
          v
12. Validate Health / Readiness
          |
          v
13. Configure Alerts
          |
          v
14. Test Rollback
          |
          v
15. Validate Disaster Recovery
Interview Explanation

A concise explanation of the project:

I built a production-oriented DevOps platform for a Node.js fleet-tracking application. I containerized the application using a multi-stage Docker build and ran it with PostgreSQL through Docker Compose for local development.

For infrastructure, I created Terraform configurations for Azure Container Apps, Azure Container Registry, PostgreSQL Flexible Server, VNet, subnets, NSGs, Key Vault, Managed Identity, RBAC, and monitoring.

I separated development, staging, and production Terraform configurations and added GitHub Actions workflows for CI, security scanning, and deployment.

For security, I implemented JWT authentication, parameterized SQL queries, environment-based configuration, non-root containers, removal of npm from the runtime image, Azure Key Vault, Managed Identity, and RBAC.

I also used Trivy to scan the final image. The final hardened image reported zero HIGH and CRITICAL vulnerabilities.

I validated the application locally using Docker Compose, health and readiness endpoints, Terraform validation, Git checks, and container security scanning.

I did not perform a live Azure deployment because an Azure subscription was not available, so I clearly separated locally validated implementation from Azure infrastructure that is implemented as code.

Key Engineering Decisions
Multi-stage Docker

Used to separate build dependencies from the runtime image and reduce the final image contents.

Non-root Container

Used to reduce the privileges available to the application process.

Remove npm From Runtime

The production application does not require npm at runtime.

Removing it reduced unnecessary runtime components and removed vulnerabilities originating from npm's bundled dependencies.

PostgreSQL Connection Pooling

Used to efficiently manage database connections.

Parameterized SQL

Used to protect against SQL injection.

Terraform

Used to create repeatable and version-controlled infrastructure.

Managed Identity

Used as the target Azure-native authentication mechanism instead of embedding long-lived Azure credentials.

Azure Key Vault

Used as the target centralized secret-management system.

GitHub OIDC

Used as the target authentication model for GitHub-to-Azure deployments without long-lived Azure credentials.

Health and Readiness Separation

Used to distinguish application process health from database/application readiness.

Environment Separation

Development, staging, and production configurations are separated so the same Terraform architecture can be reused across environments.

Final Project Status
Component	Status
Application	COMPLETE
PostgreSQL	COMPLETE
Docker	COMPLETE
Docker Compose	COMPLETE
Container Hardening	COMPLETE
Health Checks	COMPLETE
Readiness Checks	COMPLETE
Terraform	VALIDATED
Environment Separation	COMPLETE
Trivy Security Scan	COMPLETE
GitHub Actions	IMPLEMENTED
Azure Infrastructure Code	IMPLEMENTED
Azure Key Vault Configuration	IMPLEMENTED
Managed Identity Configuration	IMPLEMENTED
Azure RBAC Configuration	IMPLEMENTED
Azure Monitoring Configuration	IMPLEMENTED
Azure Live Deployment	NOT PERFORMED
Production Traffic Testing	NOT PERFORMED
Documentation	COMPLETE
Screenshots	COMPLETE
Final Validation Summary

The final local validation demonstrated:

Node.js Application
        |
        v
Syntax Validation
        |
        v
Docker Build
        |
        v
Docker Compose
        |
        v
PostgreSQL Healthy
        |
        v
Application Healthy
        |
        v
/health -> HTTP 200
        |
        v
/ready -> HTTP 200
        |
        v
Database Connected
        |
        v
Terraform fmt
        |
        v
Terraform validate
        |
        v
Git diff --check
        |
        v
Container Hardening
        |
        v
Trivy Scan
        |
        v
HIGH: 0
CRITICAL: 0
Author

Bhaskar Sharma

DevOps Engineer | AWS | Azure | Kubernetes | Terraform | CI/CD

GitHub:

https://github.com/dankbhardwaj