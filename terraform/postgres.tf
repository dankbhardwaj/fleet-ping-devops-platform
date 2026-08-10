resource "azurerm_private_dns_zone" "postgres" {
  name                = "${local.resource_prefix}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.main.name

  tags = local.common_tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = "${local.resource_prefix}-dns-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = azurerm_virtual_network.main.id

  registration_enabled = false
}

resource "random_password" "postgres_password" {
  length           = 24
  special          = true
  override_special = "!@#%^*-_"
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                = "${local.resource_prefix}-postgres"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  version = "16"

  delegated_subnet_id = azurerm_subnet.database.id
  private_dns_zone_id = azurerm_private_dns_zone.postgres.id

  administrator_login    = var.postgres_admin_username
  administrator_password = random_password.postgres_password.result

  zone = "1"

  storage_mb        = 32768
  auto_grow_enabled = true

  sku_name = "B_Standard_B2s"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled = false

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.postgres
  ]

  tags = local.common_tags
}

resource "azurerm_postgresql_flexible_server_database" "fleet" {
  name      = "fleetdb"
  server_id = azurerm_postgresql_flexible_server.main.id

  charset   = "UTF8"
  collation = "en_US.utf8"
}