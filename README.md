
# VexarDrive Fleet Ping Service

A production-oriented DevOps assessment project for a fleet tracking service.

The project demonstrates:

- Node.js REST API
- PostgreSQL
- Docker multi-stage builds
- Docker Compose local development
- Azure Container Apps
- Azure Container Registry
- Azure Database for PostgreSQL Flexible Server
- Azure Virtual Network and delegated subnets
- Azure Key Vault
- Managed Identity and Azure RBAC
- Terraform infrastructure as code
- GitHub Actions CI/CD
- GitHub OIDC authentication with Azure
- Trivy container security scanning
- Azure Monitor and Log Analytics
- Health and readiness endpoints
- Immutable container image deployment using Git commit SHA

---

## Architecture

```text
                         GitHub Repository
                                |
                +---------------+---------------+
                |               |               |
                v               v               v
               CI           Security         Deploy
                |             Trivy             |
                |                               |
                +---------------+---------------+
                                |
                         GitHub OIDC
                                |
                                v
                         Microsoft Azure
                                |
                         Terraform IaC
                                |
        +-----------------------+-----------------------+
        |                       |                       |
        v                       v                       v
      Azure VNet             Azure ACR             Key Vault
        |                       |                       |
        |                 fleet-ping:<SHA>             |
        |                       |                       |
        |                       v                       |
        |                Container Apps <---------------+
        |                       |
        |                       |
        +-----------+-----------+
                    |
                    v
          PostgreSQL Flexible Server
             Private Network Access

        Monitoring:
        Log Analytics + Application Insights
        + Azure Monitor Alerts