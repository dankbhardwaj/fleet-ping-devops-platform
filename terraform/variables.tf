variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "Central India"
}

variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "fleet-ping"
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be one of: dev, stage, prod."
  }
}

variable "postgres_admin_username" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "fleetadmin"
}

variable "alert_email" {
  description = "Email address for Azure Monitor alert notifications"
  type        = string
  default     = null

  validation {
    condition = var.alert_email == null || can(
      regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.alert_email)
    )

    error_message = "alert_email must be a valid email address or null."
  }
}
variable "container_image" {
  description = "Container image deployed to Azure Container Apps"
  type        = string

  default = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}
