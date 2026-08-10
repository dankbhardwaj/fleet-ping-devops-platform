# Fleet Ping Service — Security Guide

**Version:** 1.0
**Cloud Platform:** Microsoft Azure
**Infrastructure as Code:** Terraform
**Container Platform:** Azure Container Apps

---

# 1. Purpose

This document describes the security architecture and security controls implemented within the Fleet Ping Service.

The objective is to explain how application security, infrastructure security, identity management, networking, secrets management, container security, CI/CD security, and operational security are handled.

The security model follows a layered approach:

```text
Application
    |
Container
    |
Identity
    |
Network
    |
Secrets
    |
Infrastructure
    |
CI/CD
    |
Monitoring