resource "azurerm_container_app_environment" "main" {

  name                = "${local.resource_prefix}-aca-env"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  infrastructure_subnet_id = azurerm_subnet.container_apps.id

  zone_redundancy_enabled = false

  tags = local.common_tags

}

resource "azurerm_container_app" "main" {

  name                         = "${local.resource_prefix}-app"
  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = azurerm_container_app_environment.main.id

  revision_mode = "Single"

  identity {
    type = "SystemAssigned"
  }

  registry {

    server   = azurerm_container_registry.main.login_server
    identity = "System"

  }

  #
  # Container App Secrets
  #

  secret {

    name  = "db-password"
    value = azurerm_key_vault_secret.postgres_password.value

  }

  secret {

    name  = "jwt-secret"
    value = azurerm_key_vault_secret.jwt_secret.value

  }

  ingress {

    external_enabled = true
    target_port      = 3000

    traffic_weight {

      latest_revision = true
      percentage      = 100

    }

  }

  template {

    min_replicas = 1
    max_replicas = 3

    container {

      name  = "fleet-ping"
      image = "${azurerm_container_registry.main.login_server}/fleet-ping:latest"

      cpu    = 0.5
      memory = "1Gi"

      env {

        name  = "NODE_ENV"
        value = "production"

      }

      env {

        name  = "PORT"
        value = "3000"

      }

      env {

        name  = "DB_HOST"
        value = azurerm_postgresql_flexible_server.main.fqdn

      }

      env {

        name  = "DB_PORT"
        value = "5432"

      }

      env {

        name  = "DB_NAME"
        value = azurerm_postgresql_flexible_server_database.fleet.name

      }

      env {

        name  = "DB_USER"
        value = var.postgres_admin_username

      }

      env {

        name        = "DB_PASSWORD"
        secret_name = "db-password"

      }

      env {

        name        = "JWT_SECRET"
        secret_name = "jwt-secret"

      }

    }

  }

  tags = local.common_tags

}