#############################################
# Resource Group
#############################################

output "resource_group_name" {

  description = "Azure Resource Group"

  value = azurerm_resource_group.main.name

}

output "resource_group_location" {

  description = "Azure Region"

  value = azurerm_resource_group.main.location

}

#############################################
# Container Registry
#############################################

output "container_registry_name" {

  description = "Azure Container Registry"

  value = azurerm_container_registry.main.name

}

output "container_registry_login_server" {

  description = "ACR Login Server"

  value = azurerm_container_registry.main.login_server

}

#############################################
# Log Analytics
#############################################

output "log_analytics_workspace_name" {

  value = azurerm_log_analytics_workspace.main.name

}

output "log_analytics_workspace_id" {

  value = azurerm_log_analytics_workspace.main.id

}

#############################################
# Networking
#############################################

output "virtual_network_name" {

  value = azurerm_virtual_network.main.name

}

output "container_apps_subnet_id" {

  value = azurerm_subnet.container_apps.id

}

output "database_subnet_id" {

  value = azurerm_subnet.database.id

}

#############################################
# Network Security Groups
#############################################

output "container_apps_nsg_name" {

  value = azurerm_network_security_group.container_apps.name

}

output "database_nsg_name" {

  value = azurerm_network_security_group.database.name

}

#############################################
# PostgreSQL
#############################################

output "postgres_server_name" {

  value = azurerm_postgresql_flexible_server.main.name

}

output "postgres_server_fqdn" {

  value = azurerm_postgresql_flexible_server.main.fqdn

}

output "postgres_database_name" {

  value = azurerm_postgresql_flexible_server_database.fleet.name

}

#############################################
# Container Apps Environment
#############################################

output "container_app_environment_name" {

  value = azurerm_container_app_environment.main.name

}

output "container_app_environment_id" {

  value = azurerm_container_app_environment.main.id

}

#############################################
# Container App
#############################################

output "container_app_name" {

  value = azurerm_container_app.main.name

}

output "container_app_url" {

  value = azurerm_container_app.main.latest_revision_fqdn

}

#############################################
# Azure Key Vault
#############################################

output "key_vault_name" {

  value = azurerm_key_vault.main.name

}

output "key_vault_uri" {

  value = azurerm_key_vault.main.vault_uri

}

#############################################
# Application Insights
#############################################

output "application_insights_name" {

  value = azurerm_application_insights.main.name

}

output "application_insights_id" {

  value = azurerm_application_insights.main.id

}

output "application_insights_connection_string" {

  sensitive = true

  value = azurerm_application_insights.main.connection_string

}