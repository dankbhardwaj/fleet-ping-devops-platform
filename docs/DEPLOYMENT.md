# Fleet Ping Service

# Deployment Guide

Version: 1.0

Author: Bhaskar Sharma

Cloud Platform: Microsoft Azure

Infrastructure as Code: Terraform

---

# Purpose

This document explains how to deploy the Fleet Ping Service from a local development environment to Microsoft Azure.

The deployment process includes:

- Local development
- Docker deployment
- Terraform infrastructure provisioning
- Azure Container Registry
- Azure Container Apps
- GitHub Actions

---

# Deployment Architecture

```

Developer

↓

Git Push

↓

GitHub Actions

↓

Build Docker Image

↓

Push to Azure Container Registry

↓

Terraform Apply

↓

Azure Infrastructure

↓

Azure Container Apps

↓

Production

```

---

# Prerequisites

Install the following software.

| Tool | Version |
|------|----------|
| Git | Latest |
| Docker | Latest |
| Docker Compose | v2 |
| Node.js | 22.x |
| Terraform | >=1.8 |
| Azure CLI | Latest |

---

# Azure Requirements

Create or have access to:

- Azure Subscription
- Azure Resource Group
- Azure Container Registry
- Azure Container Apps Environment
- Azure Key Vault

---

# Clone Repository

```bash
git clone https://github.com/<your-github-username>/fleet-ping-service.git

cd fleet-ping-service
```

---

# Environment Configuration

Create:

```
.env
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

---

# Local Deployment

Install dependencies.

```bash
npm install
```

Run locally.

```bash
node server.js
```

---

# Docker Deployment

Build image.

```bash
docker build -t fleet-ping .
```

Run.

```bash
docker run -p 3000:3000 fleet-ping
```

---

# Docker Compose Deployment

Build.

```bash
docker compose build
```

Start.

```bash
docker compose up -d
```

Verify.

```bash
docker compose ps
```

View logs.

```bash
docker compose logs -f
```

Stop.

```bash
docker compose down
```

---

# Infrastructure Deployment

Move into Terraform directory.

```bash
cd terraform
```

Initialize providers.

```bash
terraform init
```

Format.

```bash
terraform fmt -recursive
```

Validate.

```bash
terraform validate
```

Plan.

```bash
terraform plan \
-var-file=environments/dev/terraform.tfvars
```

Apply.

```bash
terraform apply \
-var-file=environments/dev/terraform.tfvars
```

Destroy.

```bash
terraform destroy \
-var-file=environments/dev/terraform.tfvars
```

---

# Docker Image Deployment

Build.

```bash
docker build \
-t fleet-ping:latest .
```

Tag.

```bash
docker tag \
fleet-ping:latest \
<acr-name>.azurecr.io/fleet-ping:latest
```

Login.

```bash
az acr login \
--name <acr-name>
```

Push.

```bash
docker push \
<acr-name>.azurecr.io/fleet-ping:latest
```

---

# Azure Container Apps Deployment

Deploy the application.

```bash
az containerapp up \
--name fleet-ping \
--resource-group <resource-group> \
--environment <container-app-environment> \
--image <acr-name>.azurecr.io/fleet-ping:latest
```

---

# GitHub Actions Deployment

Required repository secrets:

```
AZURE_CLIENT_ID

AZURE_TENANT_ID

AZURE_SUBSCRIPTION_ID

AZURE_CLIENT_SECRET

ACR_NAME
```

Deployment workflow:

```
Push

↓

GitHub Actions

↓

Docker Build

↓

Terraform Validate

↓

Terraform Plan

↓

Push Image

↓

Azure Deployment
```

---

# Post Deployment Verification

Verify:

Application

```bash
curl https://<app-url>/
```

Health

```bash
curl https://<app-url>/health
```

Readiness

```bash
curl https://<app-url>/ready
```

---

# Validation Checklist

Infrastructure

- Resource Group created
- Virtual Network created
- NSGs associated
- PostgreSQL deployed
- Key Vault created
- Container Registry created
- Container Apps deployed

Application

- Container running
- Health endpoint responding
- Readiness endpoint successful
- JWT authentication working
- Fleet ping endpoint storing data

Monitoring

- Azure Monitor enabled
- Application Insights receiving telemetry
- Logs visible in Log Analytics

---

# Rollback Strategy

If deployment fails:

1. Review GitHub Actions logs.
2. Inspect Azure Activity Log.
3. Verify Terraform plan output.
4. Confirm Container App revision status.
5. Restore the previous container image if required.
6. Re-run Terraform after correcting configuration issues.

---

# Troubleshooting

## Terraform Validation Fails

Run:

```bash
terraform fmt -recursive

terraform validate
```

---

## Container Build Fails

Check:

- Dockerfile
- package.json
- package-lock.json

Rebuild:

```bash
docker build --no-cache .
```

---

## PostgreSQL Connection Fails

Verify:

- Database server is running
- Firewall or private networking configuration
- Database credentials
- Connection string

---

## Key Vault Access Denied

Verify:

- Managed Identity is enabled
- RBAC assignments are correct
- Required secrets exist

---

## Container App Unhealthy

Verify:

- Health endpoint
- Readiness endpoint
- Application logs
- Environment variables

---

# Deployment Summary

The Fleet Ping Service can be deployed consistently using Infrastructure as Code and containerized application delivery.

Terraform provisions Azure resources, Docker packages the application, Azure Container Registry stores container images, Azure Container Apps hosts the workload, and GitHub Actions automates validation and deployment.

The deployment process is repeatable, version-controlled, and designed to support multiple environments with minimal manual intervention.