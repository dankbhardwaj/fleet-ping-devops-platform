#############################################
# Container App Diagnostics
#############################################

resource "azurerm_monitor_diagnostic_setting" "container_app" {
  name                       = "${local.resource_prefix}-containerapp-diag"
  target_resource_id         = azurerm_container_app.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "ContainerAppConsoleLogs"
  }

  enabled_log {
    category = "SystemLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

#############################################
# PostgreSQL Diagnostics
#############################################

resource "azurerm_monitor_diagnostic_setting" "postgres" {
  name                       = "${local.resource_prefix}-postgres-diag"
  target_resource_id         = azurerm_postgresql_flexible_server.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "PostgreSQLLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}