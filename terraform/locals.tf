locals {

  common_tags = {

    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = "DevOps"

  }

  resource_prefix = "${var.project_name}-${var.environment}"

  acr_name = "${replace(var.project_name, "-", "")}${random_string.suffix.result}"

}
