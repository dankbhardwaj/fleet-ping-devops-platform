# Fleet Ping Service — Production Roadmap

This document tracks the current implementation status and future improvements for the Fleet Ping Service.

The roadmap is divided into:

- Completed
- Current Hardening
- Planned
- Future Enhancements

---

# 1. Completed

## 1.1 Application

- Environment variable validation
- PostgreSQL connection pooling
- Parameterized SQL queries
- Basic request validation
- JWT authentication
- Protected administrative endpoint
- Health endpoint
- Readiness endpoint
- Controlled application error handling

---

## 1.2 Docker

- Multi-stage Docker build
- Node.js Alpine runtime image
- Non-root container user
- Docker HEALTHCHECK
- Production-oriented runtime image
- Docker Compose local development
- Container configuration externalized through environment variables

---

## 1.3 Infrastructure

Terraform provisions the main Azure platform components.

Completed:

- Azure Resource Group
- Azure Virtual Network
- Container Apps subnet
- PostgreSQL subnet
- Subnet delegation
- Network Security Groups
- NSG associations
- Azure Container Registry
- Azure Container Apps Environment
- Azure Container App
- PostgreSQL Flexible Server
- PostgreSQL database
- Private DNS Zone
- Private DNS Virtual Network Link
- Azure Key Vault
- System Assigned Managed Identity
- Azure RBAC
- Log Analytics Workspace
- Application Insights
- Azure Monitor diagnostic settings
- Azure Monitor Action Group
- CPU alert
- Memory alert

---

# 2. Terraform

## Completed

- Terraform provider configuration
- Terraform version constraints
- Terraform formatting
- Terraform validation
- Environment-specific variable files
- Development environment configuration
- Staging environment configuration
- Production environment configuration
- Common resource tags
- Random ACR suffix generation
- Random PostgreSQL password generation
- Azure Storage remote backend configuration
- Terraform outputs
- Backend state separation by environment

Example environment structure:

```text
terraform/
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── stage/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars