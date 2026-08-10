# Fleet Ping Service — Cost Estimation & Optimization Guide

**Version:** 1.0
**Author:** Bhaskar Sharma
**Cloud Platform:** Microsoft Azure
**Infrastructure as Code:** Terraform

---

## 1. Purpose

This document explains the expected Azure cost profile of the Fleet Ping Service and identifies the main cost drivers and optimization opportunities.

The project is designed as a production-oriented DevOps assessment while keeping the development environment relatively small.

All cost figures in this document are **planning estimates only**. Actual Azure charges depend on region, resource configuration, workload, network traffic, storage consumption, monitoring ingestion, and Azure pricing changes.

---

## 2. Costing Assumptions

The development environment is based on the following configuration:

- Azure region: Central India
- One Azure Container Apps environment
- One Azure Container App
- Azure Container Registry Basic SKU
- Azure Database for PostgreSQL Flexible Server
- PostgreSQL burstable `B_Standard_B2s` SKU
- 32 GiB database storage
- Seven-day database backup retention
- Azure Key Vault Standard
- Log Analytics Workspace with 30-day retention
- Application Insights
- Azure Monitor metric alerts
- Low to moderate development traffic
- No large-scale data ingestion or high-volume telemetry

The Terraform configuration supports separate `dev`, `stage`, and `prod` environment configurations.

---

## 3. Azure Resources and Cost Profile

| Resource | Configuration | Cost Profile |
|---|---|---|
| Resource Group | Standard Azure resource group | No direct resource charge |
| Virtual Network | `10.0.0.0/16` | No direct VNet charge |
| Network Security Groups | Application and database NSGs | No direct NSG charge |
| Azure Container Registry | Basic | Fixed/usage-related |
| Azure Container Apps | 0.5 CPU / 1 GiB, 1–3 replicas | Usage based |
| PostgreSQL Flexible Server | `B_Standard_B2s` | Major cost driver |
| PostgreSQL Storage | 32 GiB | Usage/configuration based |
| Azure Key Vault | Standard | Usage based |
| Managed Identity | System Assigned | No separate identity charge |
| Log Analytics | PerGB2018 | Usage based |
| Application Insights | Workspace-based | Usage based |
| Azure Monitor Alerts | Metric alerts | Usage based |

---

## 4. Primary Cost Drivers

The most important cost drivers for this architecture are:

### 4.1 PostgreSQL Flexible Server

PostgreSQL is expected to be one of the largest baseline costs because the database server is provisioned continuously.

The current Terraform configuration uses:

```text
SKU: B_Standard_B2s
Storage: 32 GiB
Backup retention: 7 days
Public network access: disabled