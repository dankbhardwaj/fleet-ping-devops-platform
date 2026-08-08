# Fleet Ping Service

![Terraform](https://img.shields.io/badge/Terraform-1.8+-623CE4?logo=terraform)
![Azure](https://img.shields.io/badge/Azure-Cloud-0078D4?logo=microsoftazure)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)
![Node.js](https://img.shields.io/badge/Node.js-22.x-339933?logo=node.js)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?logo=githubactions)
![License](https://img.shields.io/badge/License-MIT-green)

---

# Overview

Fleet Ping Service is a production-oriented cloud-native backend application built to demonstrate modern DevOps, Cloud Infrastructure, Infrastructure as Code, CI/CD, containerization, security, and operational best practices.

The project simulates a fleet management platform where vehicles periodically send GPS location updates to a backend service. The application stores the data in PostgreSQL and exposes REST APIs for authentication, fleet telemetry ingestion, and administrative operations.

The surrounding infrastructure has been designed as if it were being deployed into a real Azure production environment using Terraform.

---

# Project Objectives

The primary goals of this project are to:

- Build secure cloud-native infrastructure
- Follow Infrastructure as Code best practices
- Deploy containerized workloads
- Secure application secrets
- Implement production-grade networking
- Demonstrate Azure platform services
- Automate deployments using GitHub Actions
- Improve operational visibility through monitoring
- Produce maintainable engineering documentation

---

# Features

## Application

- Node.js REST API
- Express framework
- PostgreSQL database
- JWT Authentication
- Request validation
- Parameterized SQL queries
- Health endpoint
- Readiness endpoint
- Docker support

---

## Security

- Environment-based configuration
- Azure Key Vault integration
- Managed Identity
- JWT authentication
- Non-root Docker container
- SQL Injection prevention
- Docker image hardening
- GitHub Actions security scanning

---

## Infrastructure

- Azure Resource Group
- Azure Virtual Network
- Azure Network Security Groups
- Azure Container Registry
- Azure Container Apps
- Azure Database for PostgreSQL Flexible Server
- Azure Log Analytics Workspace
- Azure Application Insights
- Azure Monitor
- Terraform remote backend (design)
- Multi-environment Terraform structure

---

## DevOps

- Docker
- Docker Compose
- GitHub Actions CI
- GitHub Actions CD (template)
- Terraform validation
- Infrastructure automation
- Health checks
- Monitoring
- Production documentation

---

# Technology Stack

| Category | Technology |
|----------|------------|
| Backend | Node.js, Express |
| Database | PostgreSQL |
| Authentication | JWT |
| Containerization | Docker, Docker Compose |
| Cloud | Microsoft Azure |
| Infrastructure as Code | Terraform |
| CI/CD | GitHub Actions |
| Container Registry | Azure Container Registry |
| Compute | Azure Container Apps |
| Secrets | Azure Key Vault |
| Identity | Managed Identity |
| Monitoring | Azure Monitor, Log Analytics, Application Insights |

---

# High-Level Architecture

```text
                GitHub

                   │

           GitHub Actions

                   │

          Build Docker Image

                   │

     Azure Container Registry

                   │

        Azure Container Apps

                   │

          Fleet Ping Service

          │               │

          │               │

     Azure Key Vault   PostgreSQL

          │               │

          └──────┬────────┘

                 │

         Azure Monitor

                 │

      Log Analytics Workspace

                 │

      Application Insights
```

---

# Repository Structure

```
fleet-ping-service/

├── config/
├── docs/
├── middleware/
├── terraform/
├── .github/
├── Dockerfile
├── docker-compose.yml
├── package.json
├── server.js
└── README.md
```

---

# Current Project Status

| Component | Status |
|-----------|--------|
| Application | ✅ Complete |
| Docker | ✅ Complete |
| Security | ✅ Complete |
| PostgreSQL | ✅ Complete |
| Terraform | ✅ Complete |
| Azure Infrastructure | ✅ Ready for Deployment |
| GitHub Actions CI | ✅ Complete |
| GitHub Actions CD | ✅ Template Ready |
| Documentation | 🚧 In Progress |
| Azure Deployment | ⏳ Pending Azure Subscription |

---

# Local Development

## Prerequisites

Install the following software before running the project:

| Software | Version |
|----------|---------|
| Git | Latest |
| Docker | 24+ |
| Docker Compose | v2 |
| Node.js | 22.x |
| npm | Latest |
| Terraform | 1.8+ |
| Azure CLI | Latest (Optional) |

---

# Clone Repository

```bash
git clone https://github.com/<your-github-username>/fleet-ping-service.git

cd fleet-ping-service
```

---

# Environment Variables

Create a `.env` file.

```bash
cp .env.example .env
```

Example:

```env
PORT=3000

DB_HOST=db
DB_PORT=5432
DB_NAME=vexar_fleet
DB_USER=vexaradmin
DB_PASSWORD=change_me

JWT_SECRET=ReplaceWithSecureSecret
```

Never commit the `.env` file.

---

# Running with Docker Compose

Build containers

```bash
docker compose build
```

Start containers

```bash
docker compose up -d
```

View logs

```bash
docker compose logs -f
```

Stop containers

```bash
docker compose down
```

Remove volumes

```bash
docker compose down -v
```

---

# Verify Application

Home Page

```bash
curl http://localhost:3000
```

Expected

```
VexarDrive Fleet Ping Service is running
```

---

Health Endpoint

```bash
curl http://localhost:3000/health
```

Example

```json
{
  "status":"UP",
  "service":"fleet-ping-service",
  "timestamp":"2026-08-08T10:00:00Z"
}
```

---

Readiness Endpoint

```bash
curl http://localhost:3000/ready
```

Example

```json
{
  "status":"READY",
  "database":"connected"
}
```

---

# Running without Docker

Install dependencies

```bash
npm install
```

Run server

```bash
node server.js
```

Development mode

```bash
npm run dev
```

---

# API Endpoints

## Root

```
GET /
```

Returns application status.

---

## Health

```
GET /health
```

Returns liveness information.

---

## Readiness

```
GET /ready
```

Verifies PostgreSQL connectivity.

---

## Driver Login

```
POST /api/auth/login
```

Example Request

```json
{
  "phone":"9999999999",
  "otp":"123456"
}
```

Example Response

```json
{
  "token":"<jwt-token>"
}
```

---

## Fleet Ping

```
POST /api/fleet/ping
```

Example

```json
{
  "vehicleId":"VH001",
  "lat":28.6139,
  "lng":77.2090,
  "speed":42,
  "timestamp":"2026-08-08T10:30:00Z"
}
```

Response

```json
{
  "status":"ok"
}
```

---

## Admin Drivers

```
GET /api/admin/drivers
```

Authorization Header

```
Authorization: Bearer <JWT_TOKEN>
```

---

# Docker Image

Build

```bash
docker build -t fleet-ping .
```

Run

```bash
docker run -p 3000:3000 fleet-ping
```

List images

```bash
docker images
```

---

# Docker Compose Services

| Service | Port |
|----------|------|
| Fleet Ping API | 3000 |
| PostgreSQL | 5432 |

---

# Database

Database

```
vexar_fleet
```

Tables

```
drivers

fleet_pings
```

Database schema is automatically initialized through:

```
schema.sql
```

during PostgreSQL container startup.

---

# Health Checks

Application

```
/health
```

Readiness

```
/ready
```

Docker

Configured using Docker HEALTHCHECK.

PostgreSQL

Configured using:

```
pg_isready
```

---

# Local Testing Checklist

- Docker image builds successfully
- Docker Compose starts successfully
- PostgreSQL initializes automatically
- Health endpoint returns HTTP 200
- Readiness endpoint verifies database connectivity
- Driver login generates JWT
- Protected endpoints require authentication
- Fleet ping data is stored successfully

---

# Azure Infrastructure

The infrastructure is provisioned using **Terraform** and follows Infrastructure as Code (IaC) principles.

---

## Azure Services

The following Azure resources are included:

| Service | Purpose |
|----------|---------|
| Resource Group | Logical container for all resources |
| Virtual Network | Private network for application resources |
| Network Security Groups | Network traffic filtering |
| Azure Container Registry | Stores Docker images |
| Azure Container Apps | Hosts the Fleet Ping API |
| Azure Database for PostgreSQL Flexible Server | Application database |
| Azure Key Vault | Secrets management |
| Managed Identity | Passwordless authentication |
| Log Analytics Workspace | Centralized logging |
| Azure Monitor | Metrics and alerting |
| Application Insights | Application performance monitoring |

---

# Terraform Structure

```
terraform/

├── backend.tf
├── providers.tf
├── versions.tf
├── variables.tf
├── locals.tf
├── outputs.tf
├── resource-group.tf
├── network.tf
├── nsg.tf
├── acr.tf
├── postgres.tf
├── keyvault.tf
├── identity.tf
├── monitoring.tf
├── alerts.tf
├── container-app.tf
├── terraform.tfvars.example
│
├── environments/
│   ├── dev/
│   ├── stage/
│   └── prod/
│
└── modules/
```

---

# Terraform Workflow

Initialize

```bash
cd terraform

terraform init
```

Validate

```bash
terraform validate
```

Format

```bash
terraform fmt -recursive
```

Plan

```bash
terraform plan \
-var-file=environments/dev/terraform.tfvars
```

Apply

```bash
terraform apply \
-var-file=environments/dev/terraform.tfvars
```

Destroy

```bash
terraform destroy \
-var-file=environments/dev/terraform.tfvars
```

---

# Infrastructure Features

## Networking

- Virtual Network
- Dedicated subnets
- NSG associations
- Service delegation
- Private PostgreSQL networking

---

## Security

- Azure Key Vault
- Managed Identity
- Secrets stored outside application code
- Passwordless Azure authentication
- Private database access
- JWT authentication

---

## Container Platform

Azure Container Apps provides:

- Autoscaling
- HTTPS ingress
- Managed runtime
- Health probes
- Container revisions
- Managed infrastructure

---

## Database

Azure Database for PostgreSQL Flexible Server provides:

- Managed PostgreSQL
- Automatic backups
- Private networking
- High availability support
- Monitoring integration

---

## Monitoring

The platform integrates with:

- Azure Monitor
- Log Analytics
- Application Insights
- Diagnostic Settings
- Metric Alerts

This provides centralized logging, metrics, and operational visibility.

---

# CI/CD

GitHub Actions automates validation and deployment.

Current workflows:

```
.github/workflows/

ci.yml

deploy.yml

security.yml
```

---

## Continuous Integration

CI performs:

- Checkout repository
- Install dependencies
- Build application
- Build Docker image
- Terraform formatting
- Terraform validation

---

## Continuous Deployment

Deployment workflow performs:

- Azure authentication
- Azure Container Registry login
- Docker image push
- Terraform initialization
- Terraform validation
- Terraform planning
- Azure Container Apps deployment

> **Note:** The deployment workflow is provided as a template. To execute it, configure an Azure subscription, Azure resources, and the required GitHub repository secrets (such as client ID, tenant ID, subscription ID, and ACR name).

---

# GitHub Actions

Example execution:

```
Developer

↓

Git Push

↓

GitHub Actions

↓

Build

↓

Docker

↓

Terraform Validate

↓

Terraform Plan

↓

Push Image

↓

Azure Container Apps

↓

Production
```

---

# Infrastructure Outputs

Terraform provides outputs for:

- Resource Group
- Azure Container Registry
- PostgreSQL
- Virtual Network
- Subnets
- Container App
- Key Vault
- Application Insights
- Log Analytics

---

# Multi-Environment Design

The project is prepared for multiple environments.

```
terraform/

environments/

├── dev
├── stage
└── prod
```

Each environment maintains its own variables while sharing the same infrastructure code.

---

# Infrastructure Security

The infrastructure follows several security best practices:

- No secrets committed to Git
- Azure Key Vault for secret storage
- Managed Identity for Azure resource access
- Private PostgreSQL networking
- Non-root Docker containers
- Parameterized SQL queries
- JWT authentication
- Health and readiness endpoints
- Docker image scanning in CI

---


# Monitoring & Observability

The platform includes built-in monitoring and operational visibility.

## Azure Monitor

Azure Monitor collects infrastructure metrics and platform diagnostics for Azure resources.

---

## Application Insights

Application Insights provides:

- Application performance monitoring
- Request telemetry
- Exception tracking
- Response time analysis
- Dependency monitoring

---

## Log Analytics

Centralized logging is provided through Azure Log Analytics.

Logs collected include:

- Container logs
- Platform logs
- PostgreSQL logs
- Azure Monitor diagnostics

---

## Health Monitoring

The application exposes two operational endpoints.

### Health Check

```
GET /health
```

Used to determine whether the application process is running.

---

### Readiness Check

```
GET /ready
```

Verifies database connectivity before reporting the service as ready to receive traffic.

---

# Security

Security has been considered throughout the project.

## Application Security

- JWT Authentication
- Request validation
- SQL Injection prevention
- Environment-based configuration
- Parameterized SQL queries

---

## Infrastructure Security

- Azure Key Vault
- Managed Identity
- Private PostgreSQL networking
- Network Security Groups
- Azure RBAC
- Secure secret management

---

## Container Security

- Multi-stage Docker build
- Non-root container
- Minimal runtime image
- Docker HEALTHCHECK
- Image vulnerability scanning

---

# Engineering Documentation

Additional documentation is available in the `docs/` directory.

| Document | Description |
|----------|-------------|
| REVIEW.md | Production readiness review |
| DECISIONS.md | Engineering decisions |
| REPORT.md | Technical implementation report |
| TODO.md | Project roadmap |
| ARCHITECTURE.md | Infrastructure architecture |
| DEPLOYMENT.md | Deployment guide |
| RUNBOOK.md | Operational procedures |
| SECURITY.md | Security practices |
| COST.md | Estimated Azure costs |

---

# Repository Structure

```
.
├── .github/
│   └── workflows/
├── config/
├── docs/
├── middleware/
├── terraform/
├── Dockerfile
├── docker-compose.yml
├── package.json
├── server.js
└── README.md
```

---

# Future Improvements

The project is production-ready but can be extended with additional enterprise capabilities.

Planned improvements include:

- Blue/Green deployments
- Canary deployments
- Multi-region deployment
- Disaster Recovery automation
- Policy as Code (OPA/Azure Policy)
- Kubernetes (AKS) deployment option
- Cost optimization dashboards
- Automated backup verification
- Secret rotation automation
- Distributed tracing enhancements

---

# Screenshots

Recommended screenshots for the GitHub repository:

- Application running locally
- Docker Compose containers
- GitHub Actions workflow
- Terraform validation
- Azure Resource Group
- Azure Container Registry
- Azure Container Apps
- PostgreSQL Flexible Server
- Azure Monitor dashboard
- Application Insights dashboard

Store screenshots under:

```
docs/images/
```

---

# License

This project is licensed under the MIT License.

---

# Author

**Bhaskar Sharma**

DevOps Engineer | Cloud Engineer | AWS | Azure | Terraform | Docker | Kubernetes | GitHub Actions

GitHub:

```
https://github.com/dankbhardwaj
```

LinkedIn:

```
https://www.linkedin.com/in/bhaskar-sharma-718122202/
```

---

# Acknowledgements

This project was developed to demonstrate practical DevOps and Cloud Engineering skills, including:

- Infrastructure as Code
- Cloud-native application deployment
- Containerization
- CI/CD automation
- Azure platform services
- Production security
- Monitoring and observability
- Operational documentation

The implementation follows modern engineering practices commonly used in production cloud environments.

---

# Project Status

✅ Application Development Complete

✅ Infrastructure as Code Complete

✅ Docker & Containerization Complete

✅ CI Pipeline Complete

✅ Deployment Pipeline Template Complete

✅ Security Hardening Complete

✅ Monitoring Integration Complete

✅ Documentation Complete

⏳ Azure Deployment Pending (requires Azure subscription)

---

# Support

If you find this project useful, consider giving the repository a ⭐ on GitHub.

Contributions, suggestions, and feedback are always welcome.