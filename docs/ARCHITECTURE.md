# Fleet Ping Service — Architecture

**Version:** 1.0
**Cloud Platform:** Microsoft Azure
**Infrastructure as Code:** Terraform
**Container Platform:** Azure Container Apps
**Database:** Azure Database for PostgreSQL Flexible Server

---

## 1. Purpose

This document describes the architecture of the Fleet Ping Service and explains how the application, networking, security, infrastructure, deployment, and monitoring components work together.

The architecture is designed as a production-oriented DevOps assessment implementation using managed Azure services and Infrastructure as Code.

The main objectives are:

- reproducible infrastructure
- secure application deployment
- private database connectivity
- centralized secrets management
- managed identity and least-privilege access
- immutable container deployments
- automated CI/CD
- health and readiness monitoring
- centralized logging and alerting
- environment-specific infrastructure configuration

---

# 2. Architecture Overview

```text
                              Developer
                                  |
                                  v
                         GitHub Repository
                                  |
                 +----------------+----------------+
                 |                |                |
                 v                v                v
                CI             Security          Deploy
                 |              Trivy              |
                 |                                |
                 +----------------+---------------+
                                  |
                                  v
                           GitHub OIDC
                                  |
                                  v
                         Microsoft Azure
                                  |
                           Terraform IaC
                                  |
        +-------------------------+-------------------------+
        |                         |                         |
        v                         v                         v
   Azure Virtual             Azure Container          Azure Key Vault
      Network                   Registry                    |
        |                         |                         |
        |                    Image fleet-ping               |
        |                       :<GIT-SHA>                  |
        |                         |                         |
        |                         v                         |
        |                Azure Container Apps <-------------+
        |                         |
        |                         |
        +------------+------------+
                     |
                     v
          PostgreSQL Flexible Server
             Private Network Access

Monitoring:
    |
    +-- Log Analytics
    +-- Application Insights
    +-- Azure Monitor Alerts