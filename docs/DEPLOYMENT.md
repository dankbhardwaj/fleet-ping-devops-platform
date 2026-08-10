# Fleet Ping Service — Deployment Guide

**Version:** 1.0
**Author:** Bhaskar Sharma
**Cloud Platform:** Microsoft Azure
**Infrastructure as Code:** Terraform
**Container Platform:** Azure Container Apps

---

## 1. Purpose

This document explains how to deploy the Fleet Ping Service from local development to Microsoft Azure.

The deployment process covers:

- Local application development
- Docker image creation
- Docker Compose
- Terraform infrastructure provisioning
- Azure Container Registry
- Azure Container Apps
- PostgreSQL Flexible Server
- Azure Key Vault
- Managed Identity
- GitHub Actions CI/CD
- GitHub OIDC authentication
- Immutable container image deployment
- Deployment verification
- Rollback and troubleshooting

---

# 2. Deployment Architecture

```text
Developer
    |
    | git push
    v
GitHub Repository
    |
    +-----------------------------+
    |                             |
    v                             v
CI Workflow                 Security Workflow
    |                             |
    |                         Trivy Scan
    |                             |
    +-------------+---------------+
                  |
                  v
          Deploy Workflow
                  |
                  v
          GitHub OIDC
                  |
                  v
          Microsoft Azure
                  |
             Terraform
                  |
        +---------+----------+
        |                    |
        v                    v
      Azure                 Azure
      ACR                Infrastructure
        |                    |
        |              +-----+------+
        |              |            |
        |             VNet       Key Vault
        |              |            |
        |        +-----+-----+      |
        |        |           |      |
        |       ACA       PostgreSQL|
        |        |           |      |
        +------> |           |      |
          SHA    |           |      |
          Image +-----------+------+