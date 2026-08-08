# Fleet Ping Service

# Architecture Documentation

Version: 1.0

Author: Bhaskar Sharma

Cloud Platform: Microsoft Azure

Infrastructure as Code: Terraform

---

# Purpose

This document describes the overall architecture of the Fleet Ping Service, including the application, infrastructure, networking, security, monitoring, and deployment components.

The objective is to provide a clear understanding of how the platform is designed and how its individual components interact.

---

# Architecture Principles

The solution follows the following engineering principles:

- Cloud-native design
- Infrastructure as Code
- Immutable infrastructure
- Least privilege security
- Managed cloud services
- Production readiness
- Operational observability
- Scalability
- Maintainability

---

# High-Level Architecture

```
                    GitHub Repository
                           │
                           │
                   GitHub Actions
                           │
          ┌────────────────┴────────────────┐
          │                                 │
   Build Docker Image             Terraform Validation
          │                                 │
          └────────────────┬────────────────┘
                           │
                 Azure Container Registry
                           │
                           │
                 Azure Container Apps
                           │
          ┌────────────────┴────────────────┐
          │                                 │
     Fleet Ping API                Managed Identity
          │                                 │
          │                                 │
 Azure Key Vault                 PostgreSQL Flexible Server
          │                                 │
          └────────────────┬────────────────┘
                           │
                    Azure Monitor
                           │
          ┌────────────────┴────────────────┐
          │                                 │
     Log Analytics              Application Insights
```

---

# Solution Components

## Node.js Application

The backend application provides REST APIs for:

- Driver authentication
- Fleet telemetry ingestion
- Administrative APIs
- Health monitoring
- Readiness verification

The application is containerized using Docker and deployed to Azure Container Apps.

---

## Azure Container Apps

Azure Container Apps hosts the Fleet Ping API.

Responsibilities include:

- Running containers
- HTTPS ingress
- Autoscaling
- Health monitoring
- Revision management

---

## Azure Container Registry

Azure Container Registry stores Docker images built through the CI/CD pipeline.

Benefits include:

- Secure image storage
- Versioned container images
- Integration with Azure Container Apps

---

## PostgreSQL Flexible Server

Azure Database for PostgreSQL Flexible Server stores application data.

Database responsibilities:

- Driver records
- Fleet location data
- Transaction processing

The database is deployed inside a delegated subnet with private networking.

---

## Azure Key Vault

Azure Key Vault stores sensitive configuration.

Examples include:

- Database password
- JWT secret

Secrets are separated from application code.

---

## Managed Identity

The Container App uses a System Assigned Managed Identity.

Benefits:

- No embedded credentials
- Azure-native authentication
- Improved security
- Simplified secret access

---

## Virtual Network

A dedicated Azure Virtual Network isolates application resources.

Address space:

```
10.0.0.0/16
```

---

## Subnets

### Container Apps Subnet

```
10.0.1.0/24
```

Hosts:

- Azure Container Apps Environment

---

### PostgreSQL Subnet

```
10.0.2.0/24
```

Hosts:

- PostgreSQL Flexible Server

---

## Network Security Groups

Dedicated NSGs protect each subnet.

Responsibilities include:

- HTTPS access
- Internal communication
- Traffic filtering

---

# Security Architecture

Security is implemented across multiple layers.

## Application

- JWT Authentication
- Request validation
- SQL Injection prevention

---

## Infrastructure

- Azure Key Vault
- Managed Identity
- Private networking
- Network Security Groups

---

## Containers

- Non-root user
- Multi-stage Docker image
- Docker HEALTHCHECK

---

# Monitoring Architecture

Monitoring consists of:

- Azure Monitor
- Log Analytics Workspace
- Application Insights

These services provide:

- Infrastructure metrics
- Application metrics
- Container logs
- Exception tracking
- Performance monitoring

---

# Deployment Flow

```
Developer

↓

Git Push

↓

GitHub Actions

↓

Build Docker Image

↓

Terraform Validate

↓

Terraform Plan

↓

Push Image to ACR

↓

Azure Container Apps

↓

Production
```

---

# Request Flow

```
Client

↓

HTTPS Request

↓

Container App

↓

Express Application

↓

Authentication

↓

Business Logic

↓

PostgreSQL

↓

HTTP Response
```

---

# Terraform Architecture

Infrastructure is managed using Terraform.

Main resources include:

- Resource Group
- Virtual Network
- Subnets
- NSGs
- Azure Container Registry
- Azure Container Apps
- PostgreSQL
- Key Vault
- Managed Identity
- Monitoring

Terraform commands:

```bash
terraform init

terraform fmt

terraform validate

terraform plan

terraform apply
```

---

# Scalability

The architecture supports:

- Container autoscaling
- Managed PostgreSQL
- Environment isolation
- Infrastructure automation

---

# Availability

Availability is improved through:

- Health endpoints
- Readiness probes
- Managed Azure services
- Docker health checks

---

# Architecture Summary

The Fleet Ping Service follows a layered cloud-native architecture that separates infrastructure, networking, security, application logic, and monitoring.

The solution combines Azure managed services with Terraform-based Infrastructure as Code to create a maintainable, scalable, and production-oriented platform.

The architecture is designed to support future enhancements such as blue/green deployments, multi-region expansion, Kubernetes migration, and advanced observability without requiring significant redesign.