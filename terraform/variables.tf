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
}
