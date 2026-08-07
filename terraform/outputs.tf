output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "resource_group_location" {
  value = azurerm_resource_group.main.location
}

output "container_registry_name" {
  value = azurerm_container_registry.main.name
}

output "container_registry_login_server" {
  value = azurerm_container_registry.main.login_server
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "container_apps_subnet_id" {
  value = azurerm_subnet.container_apps.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database.id
}

output "container_app_environment_name" {
  value = azurerm_container_app_environment.main.name
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.main.id
}

output "container_apps_nsg_name" {
  value = azurerm_network_security_group.container_apps.name
}

output "database_nsg_name" {
  value = azurerm_network_security_group.database.name
}

output "postgres_server_name" {

  value = azurerm_postgresql_flexible_server.main.name

}

output "postgres_fqdn" {

  value = azurerm_postgresql_flexible_server.main.fqdn

}

output "postgres_database" {

  value = azurerm_postgresql_flexible_server_database.fleet.name

}

output "container_app_name" {

  value = azurerm_container_app.main.name

}

output "container_app_url" {

  value = azurerm_container_app.main.latest_revision_fqdn

}
output "postgres_admin_username" {

  description = "PostgreSQL administrator username"

  value = var.postgres_admin_username

}
