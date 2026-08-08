# Fleet Ping Service

# Operations Runbook

Version: 1.0

Author: Bhaskar Sharma

Cloud Platform: Microsoft Azure

---

# Purpose

This runbook provides operational procedures for managing, monitoring, and troubleshooting the Fleet Ping Service.

It is intended for DevOps Engineers, Cloud Engineers, Site Reliability Engineers (SREs), and Operations teams responsible for maintaining the platform in production.

---

# Service Overview

Application

- Fleet Ping Service

Technology

- Node.js
- Express
- PostgreSQL
- Docker
- Azure Container Apps

Cloud Services

- Azure Container Apps
- Azure Container Registry
- Azure Database for PostgreSQL Flexible Server
- Azure Key Vault
- Azure Monitor
- Application Insights
- Log Analytics Workspace

---

# Service Health Checks

## Application Health

Endpoint

```
GET /health
```

Expected Response

```json
{
  "status":"UP",
  "service":"fleet-ping-service"
}
```

---

## Readiness Check

Endpoint

```
GET /ready
```

Expected Response

```json
{
  "status":"READY",
  "database":"connected"
}
```

If the endpoint returns:

```json
{
  "status":"NOT_READY"
}
```

the application should not receive production traffic until the issue is resolved.

---

# Daily Operational Checks

Verify:

- Azure Container App is running
- Latest deployment completed successfully
- Container image is current
- PostgreSQL server is healthy
- Key Vault is accessible
- Health endpoint returns HTTP 200
- Readiness endpoint returns HTTP 200
- No critical alerts in Azure Monitor
- Application Insights shows normal response times
- Log Analytics contains no recurring errors

---

# Troubleshooting Guide

## Scenario 1

### Application is Unreachable

Symptoms

- HTTP 502
- HTTP 503
- Connection timeout

Checks

```bash
az containerapp show \
--name fleet-ping
```

Review

- Container revision
- Ingress configuration
- Container status

Resolution

- Restart the Container App
- Verify image deployment
- Check application logs

---

## Scenario 2

### Health Endpoint Fails

Symptoms

```
GET /health

↓

500
```

Possible Causes

- Application crash
- Runtime exception
- Container startup failure

Actions

Check logs

```bash
az containerapp logs show \
--name fleet-ping
```

Verify

- Environment variables
- Startup errors
- Dependency failures

---

## Scenario 3

### Readiness Endpoint Returns NOT_READY

Symptoms

```json
{
 "status":"NOT_READY"
}
```

Possible Causes

- PostgreSQL unavailable
- Incorrect credentials
- DNS resolution failure
- Network connectivity issue

Verify

- PostgreSQL status
- Database connection string
- Private DNS
- NSG rules

Resolution

Restore database connectivity and verify:

```bash
curl /ready
```

returns HTTP 200.

---

## Scenario 4

### Database Connection Failure

Symptoms

```
ECONNREFUSED
```

Possible Causes

- PostgreSQL stopped
- Incorrect hostname
- Firewall or NSG restrictions
- Invalid credentials

Verify

- PostgreSQL Flexible Server status
- Private DNS resolution
- Azure networking
- Key Vault secrets

---

## Scenario 5

### Image Pull Failure

Symptoms

Container fails to start.

Possible Causes

- Image missing
- Incorrect image tag
- Azure Container Registry authentication failure

Verify

- Image exists in ACR
- Managed Identity permissions
- Registry configuration

---

## Scenario 6

### Key Vault Access Denied

Symptoms

Application cannot retrieve secrets.

Possible Causes

- Missing RBAC role
- Managed Identity disabled
- Secret deleted

Verify

- Managed Identity
- Key Vault role assignments
- Secret names

---

## Scenario 7

### High CPU Usage

Symptoms

- Increased response times
- CPU alerts

Checks

Review:

- Application Insights
- Azure Monitor metrics

Resolution

- Increase Container App CPU allocation
- Increase maximum replicas
- Investigate inefficient queries

---

## Scenario 8

### High Memory Usage

Symptoms

- Container restarts
- OOMKilled events

Resolution

- Increase memory allocation
- Review application logs
- Investigate memory leaks

---

## Scenario 9

### GitHub Actions Failure

Checks

Review:

- Workflow logs
- Terraform validation
- Docker build output

Verify

- Repository secrets
- Azure credentials
- Terraform syntax

---

# Routine Maintenance

Weekly

- Review Azure Monitor alerts
- Review Application Insights
- Review failed deployments
- Review container image versions

Monthly

- Rotate application secrets
- Update Docker base image
- Update Terraform providers
- Review RBAC assignments
- Apply dependency updates

Quarterly

- Review architecture
- Review Azure costs
- Review backup strategy
- Validate disaster recovery procedures

---

# Backup and Recovery

Database

- Azure PostgreSQL automated backups
- Backup retention configured in Terraform

Recovery

- Restore PostgreSQL from Azure backup
- Redeploy infrastructure using Terraform
- Redeploy application from Azure Container Registry

---

# Escalation Process

Level 1

Operations Engineer

Responsible for:

- Initial investigation
- Log analysis
- Health verification

---

Level 2

DevOps Engineer

Responsible for:

- Infrastructure
- CI/CD
- Networking
- Azure resources

---

Level 3

Cloud Architect / Platform Engineer

Responsible for:

- Architecture changes
- Disaster recovery
- Security incidents
- Capacity planning

---

# Useful Commands

Docker

```bash
docker compose ps

docker compose logs -f

docker compose down
```

Terraform

```bash
terraform fmt

terraform validate

terraform plan

terraform apply
```

Azure CLI

```bash
az login

az account show

az containerapp list

az acr list

az postgres flexible-server list

az keyvault list
```

Health

```bash
curl http://localhost:3000/health

curl http://localhost:3000/ready
```

---

# Operational Best Practices

- Never store secrets in source code.
- Validate Terraform before applying changes.
- Deploy through GitHub Actions whenever possible.
- Monitor application health continuously.
- Rotate credentials regularly.
- Keep Terraform state secure.
- Test rollback procedures before production releases.
- Review monitoring dashboards after every deployment.

---

# Runbook Summary

This runbook provides the standard operating procedures for the Fleet Ping Service, covering health verification, troubleshooting, maintenance, backup and recovery, escalation, and operational best practices.

It should be updated whenever the application architecture, deployment process, or operational procedures change.
