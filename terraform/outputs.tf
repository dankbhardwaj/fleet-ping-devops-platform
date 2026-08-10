#############################################
# Resource Group
#############################################

output "resource_group_name" {
  description = "Azure Resource Group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Azure Region"
  value       = azurerm_resource_group.main.location
}

#############################################
# Container Registry
#############################################

output "container_registry_name" {
  description = "Azure Container Registry"
  value       = azurerm_container_registry.main.name
}

output "container_registry_login_server" {
  description = "ACR Login Server"
  value       = azurerm_container_registry.main.login_server
}

#############################################
# Log Analytics
#############################################

output "log_analytics_workspace_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID"
  value       = azurerm_log_analytics_workspace.main.id
}

#############################################
# Networking
#############################################

output "virtual_network_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.main.name
}

output "container_apps_subnet_id" {
  description = "Container Apps subnet resource ID"
  value       = azurerm_subnet.container_apps.id
}

output "database_subnet_id" {
  description = "PostgreSQL subnet resource ID"
  value       = azurerm_subnet.database.id
}

#############################################
# Network Security Groups
#############################################

output "container_apps_nsg_name" {
  description = "Container Apps subnet NSG name"
  value       = azurerm_network_security_group.container_apps.name
}

output "database_nsg_name" {
  description = "PostgreSQL subnet NSG name"
  value       = azurerm_network_security_group.database.name
}

#############################################
# PostgreSQL
#############################################

output "postgres_server_name" {
  description = "PostgreSQL Flexible Server name"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "postgres_server_fqdn" {
  description = "PostgreSQL Flexible Server private FQDN"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "postgres_database_name" {
  description = "Application PostgreSQL database name"
  value       = azurerm_postgresql_flexible_server_database.fleet.name
}

#############################################
# Container Apps Environment
#############################################

output "container_app_environment_name" {
  description = "Container Apps environment name"
  value       = azurerm_container_app_environment.main.name
}

output "container_app_environment_id" {
  description = "Container Apps environment resource ID"
  value       = azurerm_container_app_environment.main.id
}

#############################################
# Container App
#############################################

output "container_app_name" {
  description = "Container App HTTPS URL"
  value       = "https://${azurerm_container_app.main.latest_revision_fqdn}"
}

output "container_app_url" {
  description = "Container App HTTPS URL"
  value       = "https://${azurerm_container_app.main.latest_revision_fqdn}"
}

#############################################
# Key Vault
#############################################

output "key_vault_name" {
  description = "Azure Key Vault name"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "Azure Key Vault URI"
  value       = azurerm_key_vault.main.vault_uri
}

#############################################
# Managed Identity
#############################################

output "managed_identity_name" {
  description = "User-assigned managed identity name"
  value       = azurerm_user_assigned_identity.main.name
}

output "managed_identity_client_id" {
  description = "User-assigned managed identity client ID"
  value       = azurerm_user_assigned_identity.main.client_id
}

output "managed_identity_principal_id" {
  description = "User-assigned managed identity principal ID"
  value       = azurerm_user_assigned_identity.main.principal_id
}
