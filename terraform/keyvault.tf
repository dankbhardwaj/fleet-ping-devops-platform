resource "azurerm_key_vault" "main" {

  name = "${replace(local.resource_prefix, "-", "")}kv"

  location = azurerm_resource_group.main.location

  resource_group_name = azurerm_resource_group.main.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  purge_protection_enabled = false

  soft_delete_retention_days = 7

  rbac_authorization_enabled = true

  tags = local.common_tags

}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "postgres_password" {

  name = "postgres-password"

  value = random_password.postgres_password.result

  key_vault_id = azurerm_key_vault.main.id

}

resource "azurerm_key_vault_secret" "jwt_secret" {

  name = "jwt-secret"

  value = "ReplaceWithProductionSecret"

  key_vault_id = azurerm_key_vault.main.id

}
