# Fleet Ping Service

# Security Guide

Version: 1.0

Author: Bhaskar Sharma

Cloud Platform: Microsoft Azure

Infrastructure as Code: Terraform

---

# Purpose

This document describes the security architecture and security controls implemented within the Fleet Ping Service.

The objective is to explain how application security, infrastructure security, identity management, networking, secrets management, and operational security have been designed to protect the platform.

---

# Security Objectives

The primary security objectives are:

- Protect sensitive information
- Prevent unauthorized access
- Secure infrastructure
- Protect application APIs
- Minimize attack surface
- Follow least privilege principles
- Support secure cloud deployments

---

# Security Architecture

The platform applies security across multiple layers.

```
                    Internet

                        │

                    HTTPS Only

                        │

             Azure Container Apps

                        │

        JWT Authentication Middleware

                        │

          Fleet Ping Application

          │                     │

          │                     │

     Azure Key Vault     PostgreSQL Flexible Server

          │                     │

          └──────────┬──────────┘

                     │

           Managed Identity

                     │

        Azure RBAC & Monitoring
```

---

# Identity Management

## Managed Identity

Azure Container Apps uses a System Assigned Managed Identity.

Benefits:

- No passwords stored in code
- Automatic credential management
- Azure-native authentication
- Reduced operational risk

Managed Identity is used to access Azure resources securely without embedding credentials in the application.

---

# Authentication

Administrative APIs require JWT authentication.

Authentication flow:

```
Driver Login

↓

Phone + OTP

↓

JWT Generated

↓

Authorization Header

↓

JWT Middleware

↓

Protected Endpoint
```

Benefits:

- Stateless authentication
- Secure API access
- Token expiration support

---

# Authorization

Protected endpoints require a valid JWT.

Example:

```
GET /api/admin/drivers
```

Header:

```
Authorization: Bearer <JWT_TOKEN>
```

Requests without a valid token receive:

```
HTTP 401 Unauthorized
```

---

# Secrets Management

Sensitive values are never hardcoded.

Examples include:

- Database password
- JWT secret

Development:

```
.env
```

Production:

- Azure Key Vault
- Managed Identity
- Environment variables

Benefits:

- Secret separation
- Centralized management
- Versioning support
- Rotation capability

---

# Database Security

The application uses Azure Database for PostgreSQL Flexible Server.

Security measures include:

- Private networking
- Delegated subnet
- Parameterized SQL queries
- Connection pooling
- Azure-managed backups

The database is not exposed publicly.

---

# SQL Injection Prevention

All SQL statements use parameterized queries.

Example:

```sql
SELECT * FROM drivers WHERE phone = $1
```

Benefits:

- User input separated from SQL
- SQL Injection prevention
- Improved query safety

---

# Network Security

Network isolation is provided through:

- Azure Virtual Network
- Dedicated subnets
- Network Security Groups

Subnet layout:

```
10.0.0.0/16

│

├── Container Apps

│     10.0.1.0/24

│

└── PostgreSQL

      10.0.2.0/24
```

---

# Network Security Groups

Separate NSGs protect each subnet.

Rules include:

- HTTPS ingress
- Internal communication
- Restricted access
- Least privilege

---

# Container Security

The Docker image follows production best practices.

Features include:

- Multi-stage build
- Node.js Alpine runtime
- Non-root user
- Docker HEALTHCHECK
- Minimal attack surface

---

# Environment Variables

Configuration is externalized.

Examples:

```
DB_HOST

DB_PORT

DB_NAME

DB_USER

DB_PASSWORD

JWT_SECRET
```

Application startup validates required variables before serving requests.

---

# Input Validation

Incoming requests are validated before processing.

Checks include:

- Required fields
- Missing payloads
- Invalid requests

Benefits:

- Improved API reliability
- Reduced malformed requests
- Better application stability

---

# HTTPS

Production deployments should expose only HTTPS endpoints.

TLS termination is handled by Azure Container Apps.

HTTP should redirect to HTTPS where applicable.

---

# Logging

Application logs should never contain:

- Passwords
- JWT tokens
- Secrets
- Database credentials

Logs should focus on operational events and error diagnostics.

---

# Monitoring

Security monitoring is supported through:

- Azure Monitor
- Application Insights
- Log Analytics

Recommended alerts include:

- Failed authentication attempts
- High error rates
- Container restarts
- Database connectivity failures

---

# GitHub Security

Repository recommendations:

- Enable Dependabot
- Enable secret scanning
- Protect the main branch
- Require pull request reviews
- Require successful CI checks

---

# Terraform Security

Infrastructure is managed as code.

Recommended practices:

- Validate before apply
- Use remote state
- Restrict state access
- Review execution plans
- Version control all infrastructure

---

# Security Best Practices

- Never commit secrets to Git.
- Store production secrets in Azure Key Vault.
- Use Managed Identity instead of embedded credentials.
- Validate all application inputs.
- Use parameterized SQL queries.
- Keep Docker images updated.
- Monitor application health continuously.
- Review RBAC assignments regularly.
- Rotate credentials periodically.
- Apply security patches promptly.

---

# Security Checklist

## Application

- JWT authentication enabled
- Request validation enabled
- Parameterized SQL queries used
- Environment validation implemented

---

## Infrastructure

- Azure Key Vault configured
- Managed Identity configured
- Virtual Network deployed
- NSGs configured
- Private PostgreSQL networking

---

## Containers

- Multi-stage Docker build
- Non-root user
- Health check configured

---

## Operations

- Azure Monitor enabled
- Application Insights enabled
- Log Analytics configured
- GitHub Actions validation enabled

---

# Future Security Improvements

Potential enhancements include:

- Azure Front Door with Web Application Firewall
- Microsoft Defender for Cloud
- Automatic secret rotation
- Azure Policy
- Open Policy Agent (OPA)
- Image signing
- Software Bill of Materials (SBOM)
- Runtime threat detection

---

# Security Summary

The Fleet Ping Service implements layered security controls across the application, infrastructure, networking, identity, and operations.

By combining JWT authentication, Azure Key Vault, Managed Identity, private networking, Infrastructure as Code, and Azure monitoring, the platform provides a strong security foundation suitable for a production-oriented cloud-native application.
