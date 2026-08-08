# Fleet Ping Service

# Cost Estimation & Optimization Guide

Version: 1.0

Author: Bhaskar Sharma

Cloud Platform: Microsoft Azure

Infrastructure as Code: Terraform

---

# Purpose

This document provides an estimated monthly cost for running the Fleet Ping Service on Microsoft Azure.

The estimates are intended for planning and learning purposes. Actual costs will vary depending on region, workload, selected SKUs, storage, and log ingestion.

---

# Costing Assumptions

The following assumptions were used for the estimates:

- Development environment
- Central India region
- Single Azure Container App
- One PostgreSQL Flexible Server
- Basic Azure Container Registry
- Standard monitoring configuration
- Moderate application traffic

---

# Azure Resources

| Resource | SKU | Estimated Monthly Cost |
|----------|-----|-----------------------:|
| Resource Group | Free | $0 |
| Virtual Network | Free | $0 |
| Network Security Groups | Free | $0 |
| Azure Container Registry | Basic | ~$5 |
| Azure Container Apps | Consumption | Usage Based |
| PostgreSQL Flexible Server | B_Standard_B2s | ~$35–45 |
| Azure Key Vault | Standard | <$1 |
| Managed Identity | System Assigned | Free |
| Log Analytics Workspace | PerGB2018 | Usage Based |
| Application Insights | Workspace-based | Usage Based |
| Azure Monitor | Standard | Usage Based |

---

# Estimated Development Cost

Typical monthly cost:

| Environment | Estimated Cost |
|-------------|---------------:|
| Development | ~$45–60 |
| Test | ~$60–90 |
| Production | Depends on workload |

These values are approximate and intended as planning estimates rather than billing guarantees.

---

# Primary Cost Drivers

The largest contributors to monthly cost are typically:

1. PostgreSQL Flexible Server
2. Azure Container Apps compute usage
3. Log Analytics data ingestion
4. Application Insights telemetry
5. Azure Container Registry

---

# Cost Optimization

## Azure Container Apps

Recommendations:

- Enable autoscaling.
- Allow scale-to-zero for development workloads.
- Configure minimum replicas appropriately.
- Right-size CPU and memory allocations.

Expected benefit:

- Reduced compute cost during idle periods.
- Lower development environment expenses.

---

## PostgreSQL

Recommendations:

- Use burstable SKUs in development.
- Select only the storage required.
- Keep backup retention appropriate for the environment.
- Stop or remove unused environments.

Expected benefit:

- Lower database costs while maintaining functionality.

---

## Azure Container Registry

Recommendations:

- Use the Basic SKU for development.
- Remove unused container images regularly.
- Apply image retention policies.

Expected benefit:

- Reduced storage usage.
- Easier registry maintenance.

---

## Log Analytics

Recommendations:

- Configure suitable data retention.
- Disable unnecessary diagnostic categories.
- Monitor ingestion volume.

Expected benefit:

- Lower logging costs.

---

## Application Insights

Recommendations:

- Sample telemetry where appropriate.
- Avoid collecting unnecessary debug data in production.
- Review telemetry usage regularly.

Expected benefit:

- Reduced monitoring costs while retaining useful operational insights.

---

# Terraform Cost Management

Terraform helps control cloud costs by:

- Creating only required resources.
- Version-controlling infrastructure.
- Supporting repeatable deployments.
- Making it easy to remove temporary environments.

Useful commands:

```bash
terraform plan

terraform apply

terraform destroy
```

Destroy temporary development environments when they are no longer required.

---

# Environment Strategy

## Development

Purpose:

- Learning
- Testing
- Validation

Recommendations:

- Lowest suitable SKUs
- Autoscaling enabled
- Scale-to-zero where supported
- Reduced monitoring retention

---

## Staging

Purpose:

- Integration testing
- Deployment validation

Recommendations:

- Production-like configuration
- Moderate monitoring
- Controlled access

---

## Production

Purpose:

- Live workloads

Recommendations:

- Appropriate sizing based on demand
- High availability where required
- Full monitoring and alerting
- Regular backup verification

---

# Cost Monitoring

Azure provides several tools for monitoring cloud expenditure.

Recommended services:

- Azure Cost Management
- Azure Budgets
- Azure Monitor
- Log Analytics

Suggested alerts:

- Monthly budget threshold
- Unexpected resource creation
- High compute usage
- Rapid log ingestion growth

---

# Future Cost Improvements

Potential enhancements include:

- Reserved capacity where appropriate
- Automated shutdown of non-production resources
- Image lifecycle management
- Scheduled scaling
- Improved telemetry sampling
- Ongoing resource rightsizing

---

# Monthly Cost Summary

| Category | Approximate Cost |
|----------|-----------------:|
| Compute | Medium |
| Database | Medium |
| Networking | Low |
| Security | Low |
| Monitoring | Variable |
| Storage | Low |

Estimated development environment total:

**~$45–60 USD per month**

---

# Cost Summary

The Fleet Ping Service is designed to balance production-oriented architecture with reasonable operating costs.

Using managed Azure services simplifies operations while Terraform provides consistent provisioning and straightforward cleanup of environments that are no longer needed.

Regular cost reviews, monitoring, and rightsizing help keep the platform efficient as usage evolves.
