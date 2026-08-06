resource "random_string" "suffix" {

  length = 5

  upper = false

  lower = true

  numeric = true

  special = false

}

resource "azurerm_container_registry" "main" {

  name = local.acr_name

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  sku = "Basic"

  admin_enabled = false

  tags = local.common_tags

}
