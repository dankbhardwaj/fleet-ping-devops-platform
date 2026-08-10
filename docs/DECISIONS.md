# Fleet Ping Service — Engineering Decisions

**Version:** 1.0
**Author:** Bhaskar Sharma
**Cloud Platform:** Microsoft Azure
**Infrastructure as Code:** Terraform

---

## 1. Purpose

This document records the major engineering decisions made while building the Fleet Ping Service.

The decisions focus on:

- Security
- Reliability
- Maintainability
- Scalability
- Operational readiness
- Infrastructure automation
- Cloud-native deployment
- Cost awareness

Each decision explains the chosen approach and the reason behind it.

---

# 2. Application Configuration

## Decision

Use environment variables for application configuration.

## Why?

Environment-specific configuration should not be hardcoded into the application.

The application reads values such as:

```text
DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
JWT_SECRET
PORT
NODE_ENV