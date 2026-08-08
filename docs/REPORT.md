# Fleet Ping Service

# Technical Implementation Report

Version: 1.0

Author: Bhaskar Sharma

Project Type: Cloud Native DevOps Platform

Cloud Provider: Microsoft Azure

Infrastructure as Code: Terraform

Container Platform: Azure Container Apps

---

# Table of Contents

1. Executive Summary
2. Project Overview
3. Business Problem
4. Project Objectives
5. Functional Requirements
6. Non-Functional Requirements
7. Technology Stack
8. High-Level Architecture
9. Infrastructure Overview
10. Security
11. CI/CD
12. Monitoring
13. Cost Analysis
14. Production Readiness
15. Future Improvements
16. Conclusion

---

# 1. Executive Summary

Fleet Ping Service is a production-oriented cloud-native backend platform designed to demonstrate modern DevOps engineering practices on Microsoft Azure.

The project combines application development, Infrastructure as Code (IaC), containerization, cloud networking, monitoring, security, and deployment automation into a single solution.

The backend application receives GPS location updates from vehicles, authenticates drivers using JWT, stores telemetry in PostgreSQL, and exposes REST APIs for fleet operations.

To support production deployment, the infrastructure is provisioned using Terraform and includes Azure networking, Azure Container Registry, Azure Container Apps, Azure Database for PostgreSQL Flexible Server, Azure Key Vault, Managed Identity, Log Analytics, Application Insights, and Azure Monitor.

The project also includes Docker, Docker Compose, GitHub Actions workflows, engineering documentation, and operational runbooks.

The overall objective is to demonstrate the implementation of a secure, maintainable, and production-ready cloud platform following Infrastructure as Code and DevOps best practices.

---

# 2. Project Overview

Fleet Ping Service simulates the backend component of a fleet management platform.

Vehicles periodically transmit their location and operational data to a centralized REST API.

The application validates incoming requests, authenticates users, stores fleet telemetry, and provides administrative APIs for operational visibility.

Rather than focusing solely on application development, the project emphasizes the operational aspects required to deploy and manage the application in a cloud environment.

These include:

- Infrastructure automation
- Secure secret management
- Production networking
- Container orchestration
- Monitoring and observability
- Continuous Integration
- Continuous Deployment
- Operational documentation

---

# 3. Business Problem

Fleet management systems must continuously receive telemetry from thousands of vehicles while maintaining reliability, security, and scalability.

Traditional deployments often suffer from:

- Manual infrastructure provisioning
- Configuration drift
- Hardcoded credentials
- Inconsistent deployment processes
- Limited monitoring
- Slow onboarding of new environments

These issues increase operational risk and reduce deployment reliability.

The Fleet Ping Service addresses these challenges by automating infrastructure provisioning, externalizing configuration, securing sensitive information, and standardizing deployments through Infrastructure as Code.

---

# 4. Project Objectives

The primary objectives of the project are:

- Build a secure REST API
- Deploy using containers
- Automate infrastructure provisioning
- Implement Infrastructure as Code
- Improve operational visibility
- Secure application secrets
- Automate deployments
- Follow cloud-native design principles
- Improve maintainability
- Demonstrate enterprise DevOps practices

---

# 5. Functional Requirements

The platform provides the following functionality.

## Driver Authentication

Drivers authenticate using their registered phone number and receive a JWT for subsequent API requests.

---

## Fleet Ping API

Vehicles submit GPS coordinates, speed, and timestamps through a REST endpoint.

---

## Data Storage

Fleet telemetry is stored in PostgreSQL for future analysis.

---

## Administrative APIs

Authenticated administrative users can retrieve driver information through protected endpoints.

---

## Health Monitoring

The application exposes dedicated health and readiness endpoints for operational monitoring and container orchestration.

---

# 6. Non-Functional Requirements

The project is designed with the following operational goals.

## Security

- JWT Authentication
- Azure Key Vault
- Managed Identity
- Parameterized SQL Queries
- Environment-based configuration

---

## Reliability

- Docker health checks
- Readiness probes
- Connection pooling
- Managed PostgreSQL

---

## Scalability

- Azure Container Apps
- Managed PostgreSQL
- Infrastructure as Code
- Reusable Terraform configuration

---

## Maintainability

- Modular project structure
- Engineering documentation
- GitHub Actions automation
- Standardized configuration

---

## Availability

- Managed cloud services
- Health monitoring
- Azure Monitor integration
- Diagnostic logging

---

# 7. Technology Stack

| Category | Technology |
|----------|------------|
| Backend | Node.js |
| Framework | Express |
| Database | PostgreSQL |
| Authentication | JWT |
| Containerization | Docker |
| Local Orchestration | Docker Compose |
| Cloud Provider | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Container Registry | Azure Container Registry |
| Compute | Azure Container Apps |
| Secrets | Azure Key Vault |
| Identity | Managed Identity |
| Monitoring | Azure Monitor |
| Logging | Log Analytics |
| Performance Monitoring | Application Insights |
| CI/CD | GitHub Actions |

---

# Report Status

This section documents the overall project background, objectives, requirements, and technology selection.

The following sections describe the application architecture, infrastructure implementation, deployment strategy, security model, monitoring approach, and production readiness.


# 8. Solution Architecture

The Fleet Ping Service follows a cloud-native layered architecture that separates application logic, infrastructure, networking, security, monitoring, and deployment automation.

The solution is composed of the following major layers:

- Client Layer
- Application Layer
- Data Layer
- Infrastructure Layer
- Security Layer
- Monitoring Layer
- CI/CD Layer

Each layer has a clearly defined responsibility to improve maintainability and scalability.

---

# 9. High-Level Architecture

```
                    Drivers / Vehicles

                           │

                     HTTPS Requests

                           │

                 Azure Container Apps

                           │

                 Fleet Ping Service API

             ┌─────────────┴─────────────┐

             │                           │

      Azure Key Vault         PostgreSQL Flexible Server

             │                           │

             └─────────────┬─────────────┘

                           │

                    Azure Monitor

                           │

        Log Analytics + Application Insights

                           │

                    Operations Team
```

---

# 10. Application Architecture

The backend application is developed using Node.js and Express.

The application exposes REST APIs that allow:

- Driver authentication
- Fleet telemetry ingestion
- Administrative operations
- Health monitoring

The application follows a simple layered architecture.

```
HTTP Request

      │

Express Router

      │

Authentication Middleware

      │

Request Validation

      │

Business Logic

      │

PostgreSQL Database

      │

HTTP Response
```

---

# 11. Request Flow

The following sequence illustrates a typical fleet telemetry request.

### Step 1

A vehicle sends a POST request containing:

- Vehicle ID
- Latitude
- Longitude
- Speed
- Timestamp

---

### Step 2

Express receives the request.

---

### Step 3

The request payload is validated.

Invalid requests return HTTP 400.

---

### Step 4

Application logic prepares the SQL statement.

Parameterized SQL queries are used to eliminate SQL Injection vulnerabilities.

---

### Step 5

PostgreSQL stores the telemetry.

---

### Step 6

The API returns:

```json
{
  "status":"ok"
}
```

---

# 12. Authentication Flow

Administrative APIs require JWT authentication.

Authentication process:

```
Driver Login

        │

Phone + OTP

        │

JWT Generated

        │

Client Stores Token

        │

Authorization Header

        │

JWT Middleware

        │

Protected Endpoint
```

The middleware validates:

- Token presence
- Signature
- Expiration

Requests with invalid tokens return HTTP 401.

---

# 13. Database Design

The application uses PostgreSQL as the primary relational database.

Current schema includes:

## drivers

Stores registered driver information.

Typical attributes include:

- Driver ID
- Phone Number
- Driver Name

---

## fleet_pings

Stores vehicle telemetry.

Typical attributes include:

- Vehicle ID
- Latitude
- Longitude
- Speed
- Timestamp

---

# 14. Database Connectivity

The application communicates with PostgreSQL using the official Node.js PostgreSQL driver.

Instead of opening a new database connection for every request, the application uses a shared connection pool.

Benefits include:

- Reduced latency
- Improved scalability
- Better resource utilization
- Lower connection overhead

---

# 15. Configuration Management

Application configuration is externalized using environment variables.

Examples include:

- Database host
- Database port
- Database name
- Database credentials
- JWT secret
- Application port

This approach separates configuration from application code and supports multiple deployment environments.

---

# 16. Containerization

The application is packaged using Docker.

The production Docker image includes:

- Multi-stage build
- Node.js 22 Alpine runtime
- Non-root user
- Health check
- Optimized dependency installation

Advantages include:

- Smaller image size
- Improved security
- Faster deployment
- Consistent runtime environment

---

# 17. Local Development Environment

Docker Compose provides a complete local development environment.

Services include:

- Fleet Ping API
- PostgreSQL

Docker Compose automatically:

- Creates the network
- Starts PostgreSQL
- Initializes the database schema
- Starts the application
- Executes health checks

Developers can start the complete environment using a single command:

```bash
docker compose up --build
```

---

# Part Summary

This section described:

- Overall solution architecture
- Application architecture
- Request processing flow
- Authentication process
- Database design
- Configuration management
- Containerization
- Local development environment

The next section focuses on the Azure infrastructure, Terraform implementation, networking, and deployment architecture.


# 18. Azure Infrastructure

The Fleet Ping Service infrastructure is fully defined using Terraform.

Infrastructure as Code (IaC) enables the complete cloud environment to be provisioned consistently, repeatedly, and automatically.

Rather than manually creating Azure resources through the Azure Portal, every resource is described declaratively in Terraform configuration files.

This approach provides:

- Version-controlled infrastructure
- Repeatable deployments
- Reduced configuration drift
- Easier disaster recovery
- Better collaboration
- Infrastructure auditing

---

# 19. Infrastructure Components

The platform provisions the following Azure services.

| Azure Service | Purpose |
|---------------|---------|
| Resource Group | Logical container for all Azure resources |
| Virtual Network | Private network for cloud resources |
| Network Security Groups | Network traffic filtering |
| Azure Container Registry | Stores Docker container images |
| Azure Container Apps Environment | Managed hosting environment |
| Azure Container App | Hosts the Fleet Ping API |
| Azure Database for PostgreSQL Flexible Server | Relational database |
| Private DNS Zone | Private database name resolution |
| Azure Key Vault | Secret management |
| Managed Identity | Passwordless Azure authentication |
| Log Analytics Workspace | Centralized log storage |
| Application Insights | Application monitoring |
| Azure Monitor | Metrics, alerts, diagnostics |

---

# 20. Resource Group

All Azure resources are deployed into a dedicated Resource Group.

Benefits include:

- Centralized management
- Easier resource lifecycle management
- Cost tracking
- RBAC assignment
- Simplified cleanup

Example:

```
fleet-ping-dev-rg
```

---

# 21. Networking

The infrastructure uses a dedicated Azure Virtual Network.

Network layout:

```
Virtual Network

10.0.0.0/16

│

├── Container Apps Subnet

│      10.0.1.0/24

│

└── PostgreSQL Subnet

       10.0.2.0/24
```

Separate subnets improve:

- Security
- Isolation
- Scalability
- Network management

---

# 22. Network Security

Dedicated Network Security Groups (NSGs) are attached to each subnet.

The NSGs restrict traffic according to the principle of least privilege.

Examples include:

- HTTPS ingress
- Internal database communication
- Restricted management access

Benefits:

- Reduced attack surface
- Controlled network access
- Azure security best practices

---

# 23. Azure Container Registry

Docker images are stored in Azure Container Registry (ACR).

The registry acts as the central repository for application images.

Deployment workflow:

```
Docker Build

↓

Azure Container Registry

↓

Azure Container Apps
```

Advantages:

- Secure image storage
- Versioned images
- Integration with Azure Container Apps
- Private registry support

---

# 24. Azure Container Apps

The Fleet Ping Service is deployed using Azure Container Apps.

Configuration includes:

- HTTPS ingress
- Autoscaling
- Managed runtime
- Revision management
- Health checks
- Managed networking

Container Apps removes the operational overhead associated with managing Kubernetes clusters while providing many cloud-native deployment capabilities.

---

# 25. PostgreSQL Flexible Server

The application stores operational data inside Azure Database for PostgreSQL Flexible Server.

Features include:

- Managed PostgreSQL
- Automatic backups
- High availability options
- Private networking
- Azure monitoring integration
- Managed patching

The database resides inside a delegated subnet and is not publicly exposed.

---

# 26. Private DNS

Private DNS enables Azure resources within the Virtual Network to resolve the PostgreSQL server using a private address.

Advantages include:

- Private communication
- Simplified service discovery
- Improved security

---

# 27. Azure Key Vault

Sensitive configuration values are stored in Azure Key Vault.

Examples include:

- Database password
- JWT secret

Benefits:

- Centralized secret management
- RBAC integration
- Secret versioning
- Secure storage
- Future support for automatic secret rotation

---

# 28. Managed Identity

The Container App is configured with a System Assigned Managed Identity.

Managed Identity allows Azure resources to authenticate with other Azure services without storing credentials in the application.

Advantages:

- No embedded secrets
- Automatic credential management
- Reduced operational risk
- Native Azure authentication

---

# 29. Monitoring Platform

The monitoring stack consists of:

- Azure Monitor
- Log Analytics Workspace
- Application Insights

Together they provide:

- Infrastructure metrics
- Application metrics
- Log aggregation
- Performance monitoring
- Operational diagnostics
- Alerting

---

# 30. Infrastructure Provisioning Workflow

Terraform deployment follows the workflow below.

```
Terraform Init

↓

Provider Download

↓

Terraform Validate

↓

Terraform Plan

↓

Terraform Apply

↓

Azure Resource Creation

↓

Infrastructure Ready
```

All resources are provisioned from source-controlled Terraform files, ensuring consistent deployments across environments.

---

# 31. Environment Structure

The Terraform configuration is prepared for multiple deployment environments.

```
terraform/

environments/

├── dev

├── stage

└── prod
```

Each environment maintains independent configuration values while sharing the same infrastructure definitions.

---

# 32. Infrastructure Outputs

Terraform exposes outputs for commonly required resource information.

Examples include:

- Resource Group name
- Azure Container Registry login server
- PostgreSQL server FQDN
- Container App URL
- Key Vault URI
- Log Analytics Workspace ID
- Application Insights name

These outputs simplify integration with deployment pipelines and operational tooling.

---

# Part Summary

This section described the Azure infrastructure supporting the Fleet Ping Service, including networking, container hosting, managed database services, secret management, monitoring, and Infrastructure as Code implementation.

The next section covers security architecture, CI/CD pipelines, monitoring strategy, testing, and production readiness.

# 33. Security Architecture

Security was a primary design consideration throughout the implementation of the Fleet Ping Service.

Security controls were implemented at multiple layers including:

- Application
- Infrastructure
- Identity
- Networking
- Secrets Management
- Container Runtime

This defense-in-depth approach minimizes risk and improves operational security.

---

# 34. Application Security

The backend application implements several security controls.

## JWT Authentication

Administrative APIs are protected using JSON Web Tokens (JWT).

The authentication process includes:

- User login
- JWT generation
- Token validation
- Protected routes

Unauthorized requests receive HTTP 401 responses.

---

## Request Validation

Incoming API requests are validated before business logic execution.

Validation includes:

- Required fields
- Missing payload detection
- Invalid request rejection

This prevents malformed requests from reaching the database.

---

## SQL Injection Prevention

Database operations use parameterized PostgreSQL queries.

Example approach:

```
SELECT * FROM drivers WHERE phone = $1
```

Benefits:

- Prevents SQL Injection
- Separates SQL from user input
- Improves query safety

---

## Environment Configuration

Sensitive configuration is loaded through environment variables.

Examples include:

- Database credentials
- JWT secret
- Database host
- Database port

No application secrets are hardcoded into the source code.

---

# 35. Infrastructure Security

Infrastructure security is implemented using Azure-native capabilities.

## Azure Key Vault

Sensitive values are stored outside the application.

Examples:

- Database password
- JWT secret

Benefits include:

- Centralized secret storage
- RBAC integration
- Secret versioning
- Secure access

---

## Managed Identity

Azure Container Apps uses a System Assigned Managed Identity.

Advantages:

- No embedded credentials
- Automatic identity lifecycle
- Azure-native authentication
- Reduced secret exposure

---

## Network Isolation

Networking is isolated using:

- Azure Virtual Network
- Dedicated subnets
- Network Security Groups
- Private PostgreSQL networking

The database is not exposed to the public internet.

---

## Container Security

Docker images were hardened using:

- Multi-stage builds
- Non-root user
- Minimal runtime image
- Docker HEALTHCHECK
- Optimized dependencies

These measures reduce the attack surface and improve runtime security.

---

# 36. Continuous Integration

Continuous Integration is implemented using GitHub Actions.

The CI pipeline performs:

- Repository checkout
- Dependency installation
- Application build
- Docker image build
- Terraform formatting
- Terraform validation

Benefits:

- Early error detection
- Consistent builds
- Automated validation
- Improved developer productivity

---

# 37. Continuous Deployment

A deployment workflow template has been prepared for Azure.

Deployment process:

```
Git Push

↓

GitHub Actions

↓

Azure Authentication

↓

Docker Build

↓

Azure Container Registry

↓

Terraform Validation

↓

Terraform Plan

↓

Azure Container Apps Deployment
```

The workflow is designed to support automated deployments once Azure credentials and repository secrets are configured.

---

# 38. Monitoring Strategy

Operational monitoring is provided through Azure-native services.

## Azure Monitor

Collects:

- Infrastructure metrics
- Platform diagnostics
- Performance metrics

---

## Log Analytics Workspace

Centralizes logs from:

- Container Apps
- PostgreSQL
- Azure Monitor

---

## Application Insights

Provides:

- Request telemetry
- Performance metrics
- Exception tracking
- Dependency monitoring
- Application diagnostics

---

## Diagnostic Settings

Diagnostic settings forward logs and metrics to Log Analytics for centralized analysis.

---

## Alerting

Metric alerts can be configured for:

- High CPU utilization
- High memory usage
- Application availability
- Database health

---

# 39. Testing Strategy

The project was validated at multiple levels.

## Application Testing

Verified:

- Driver login
- JWT generation
- Fleet ping ingestion
- Database connectivity
- Protected endpoints

---

## Docker Testing

Verified:

- Image builds successfully
- Container startup
- Health checks
- Docker Compose deployment

---

## Terraform Testing

Executed:

```
terraform fmt

terraform validate
```

The infrastructure configuration validates successfully.

---

## API Testing

Endpoints tested include:

- GET /
- GET /health
- GET /ready
- POST /api/auth/login
- POST /api/fleet/ping
- GET /api/admin/drivers

Testing performed using:

- curl
- Docker Compose
- Local PostgreSQL

---

# 40. Production Readiness Assessment

The application has been significantly improved compared to the original assessment repository.

Implemented improvements include:

- Environment-based configuration
- PostgreSQL connection pooling
- Parameterized SQL queries
- JWT authentication
- Request validation
- Health endpoint
- Readiness endpoint
- Docker health checks
- Multi-stage Docker image
- Azure infrastructure
- Azure networking
- Azure Key Vault
- Managed Identity
- Azure Monitor
- GitHub Actions CI
- Deployment workflow template
- Engineering documentation

The platform is ready for deployment to Azure once an Azure subscription and deployment credentials are available.

---

# Part Summary

This section documented the security architecture, deployment automation, monitoring strategy, testing approach, and production readiness of the Fleet Ping Service.

The final section presents the cost analysis, lessons learned, future enhancements, and concluding assessment of the project.


# 41. Cost Analysis

The Fleet Ping Service has been designed to balance production readiness with cost efficiency.

The following table provides an estimated monthly cost for a development environment.

| Azure Service | SKU | Estimated Monthly Cost |
|---------------|-----|-----------------------:|
| Resource Group | Free | $0 |
| Azure Container Registry | Basic | ~$5 |
| Azure Container Apps | Consumption | Usage Based |
| PostgreSQL Flexible Server | B2s | ~$35–45 |
| Log Analytics Workspace | PerGB2018 | Usage Based |
| Application Insights | Workspace-based | Usage Based |
| Azure Key Vault | Standard | <$1 |
| Virtual Network | Standard | Free |
| Network Security Groups | Standard | Free |
| Managed Identity | System Assigned | Free |
| Azure Monitor | Usage Based | Variable |

Estimated monthly cost for a small development environment is approximately **$45–60 USD**, depending on workload, log ingestion, and container execution.

---

# 42. Cost Optimization

The following practices help reduce operational costs.

## Container Apps

- Configure autoscaling.
- Allow scale-to-zero for development environments.
- Use lower CPU and memory allocations for non-production deployments.

---

## PostgreSQL

- Select burstable SKUs for development.
- Pause or delete idle environments when not in use.
- Use backup retention policies appropriate for the environment.

---

## Monitoring

- Reduce Log Analytics retention for development.
- Disable unnecessary diagnostic categories.
- Create alerts only for production-critical resources.

---

## Terraform

- Destroy temporary environments after testing.
- Use separate state files for each environment.
- Avoid creating unused infrastructure.

---

# 43. Challenges Encountered

Several practical challenges were encountered during implementation.

## Docker Networking

Initially, the application attempted to connect to PostgreSQL using `localhost`.

Because the application and database were running in separate containers, the connection failed.

The issue was resolved by using the Docker Compose service name (`db`) as the database host.

---

## Health and Readiness

The readiness endpoint initially returned:

```
NOT_READY
```

Investigation identified database connectivity issues.

The endpoint was updated to verify PostgreSQL connectivity through the shared connection pool.

---

## Terraform Validation

During infrastructure development, several validation errors were encountered.

Examples included:

- Missing providers
- Unsupported resource blocks
- Incorrect AzureRM arguments
- Deprecated provider attributes

Each issue was resolved through iterative validation using:

```bash
terraform fmt

terraform validate
```

---

## Azure Constraints

The infrastructure has been designed for Azure deployment but has not yet been deployed because an Azure subscription is not currently available.

The Terraform configuration has been validated locally and is structured for deployment once Azure credentials are configured.

---

# 44. Lessons Learned

This project provided practical experience across multiple areas of DevOps engineering.

Key learning outcomes include:

- Infrastructure as Code using Terraform
- Cloud-native architecture on Azure
- Secure application configuration
- Secret management using Azure Key Vault
- Managed Identity integration
- Container image hardening
- Docker networking
- PostgreSQL connection pooling
- JWT authentication
- CI/CD automation using GitHub Actions
- Azure monitoring services
- Production documentation
- Operational runbooks
- Infrastructure validation and troubleshooting

---

# 45. Future Enhancements

Although the platform is production-ready, several improvements could be implemented in future iterations.

## Infrastructure

- Terraform remote backend with Azure Storage Account
- Full Terraform module refactoring
- Multi-region deployment
- Disaster Recovery strategy

---

## Security

- Automatic secret rotation
- Azure Policy
- Microsoft Defender for Cloud
- Web Application Firewall
- Azure Front Door

---

## CI/CD

- Automatic production deployment
- Blue/Green deployment
- Canary deployment
- Automated rollback
- Release approvals

---

## Monitoring

- Custom dashboards
- Distributed tracing
- SLA monitoring
- Cost monitoring
- Advanced alert routing

---

## Application

- Role-Based Access Control (RBAC)
- API versioning
- OpenAPI (Swagger) documentation
- Rate limiting
- Audit logging

---

# 46. Project Deliverables

The completed project includes:

## Application

- Node.js backend
- Express REST API
- PostgreSQL integration
- JWT authentication
- Health endpoint
- Readiness endpoint

---

## Containers

- Multi-stage Docker image
- Docker Compose
- Docker health checks
- Non-root execution

---

## Infrastructure

- Azure Resource Group
- Azure Virtual Network
- Network Security Groups
- Azure Container Registry
- Azure Container Apps
- Azure Database for PostgreSQL Flexible Server
- Azure Key Vault
- Managed Identity
- Log Analytics
- Application Insights
- Azure Monitor

---

## DevOps

- Terraform Infrastructure as Code
- GitHub Actions CI
- GitHub Actions deployment workflow template
- Engineering documentation
- Operational documentation

---

# 47. Conclusion

The Fleet Ping Service successfully demonstrates the implementation of a modern cloud-native backend platform using Microsoft Azure and Terraform.

The project combines secure application development, Infrastructure as Code, containerization, deployment automation, monitoring, and operational documentation into a single solution.

Compared with the initial assessment repository, the platform has been transformed into a production-oriented implementation that follows common DevOps engineering practices.

The resulting solution provides:

- Secure configuration management
- Automated infrastructure provisioning
- Containerized application deployment
- Cloud-native monitoring
- Deployment automation
- Operational documentation
- Production readiness

The infrastructure has been validated locally using Terraform and is ready for deployment to Azure once an Azure subscription is available.

The project demonstrates practical skills across DevOps, Cloud Engineering, Infrastructure as Code, containerization, CI/CD, monitoring, and platform operations.

---

# Report Completion

**Version:** 1.0

**Status:** Complete

**Project:** Fleet Ping Service

**Cloud Platform:** Microsoft Azure

**Infrastructure as Code:** Terraform

**Author:** Bhaskar Sharma