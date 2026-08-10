#############################################
# Action Group
#############################################

resource "azurerm_monitor_action_group" "main" {
  name                = "${local.resource_prefix}-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "fleet"

  dynamic "email_receiver" {
    for_each = var.alert_email == null ? [] : [var.alert_email]

    content {
      name          = "primary"
      email_address = email_receiver.value
    }
  }

  tags = local.common_tags
}

#############################################
# High CPU Alert
#############################################

resource "azurerm_monitor_metric_alert" "high_cpu" {
  name                = "${local.resource_prefix}-cpu-alert"
  resource_group_name = azurerm_resource_group.main.name

  scopes = [
    azurerm_container_app.main.id
  ]

  description = "Alert when Container App CPU utilization is above 80%."

  severity = 2
  enabled  = true

  frequency   = "PT5M"
  window_size = "PT15M"

  criteria {
    metric_namespace = "Microsoft.App/containerapps"
    metric_name      = "CpuPercentage"

    aggregation = "Average"
    operator    = "GreaterThan"
    threshold   = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = local.common_tags
}

#############################################
# High Memory Alert
#############################################

resource "azurerm_monitor_metric_alert" "high_memory" {
  name                = "${local.resource_prefix}-memory-alert"
  resource_group_name = azurerm_resource_group.main.name

  scopes = [
    azurerm_container_app.main.id
  ]

  description = "Alert when Container App memory utilization is above 80%."

  severity = 2
  enabled  = true

  frequency   = "PT5M"
  window_size = "PT15M"

  criteria {
    metric_namespace = "Microsoft.App/containerapps"
    metric_name      = "MemoryPercentage"

    aggregation = "Average"
    operator    = "GreaterThan"
    threshold   = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = local.common_tags
}