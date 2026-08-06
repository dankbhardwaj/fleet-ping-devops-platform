resource "azurerm_network_security_group" "container_apps" {

  name                = "${local.resource_prefix}-aca-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {

    name = "AllowHttps"

    priority = 100

    direction = "Inbound"

    access = "Allow"

    protocol = "Tcp"

    source_port_range = "*"

    destination_port_range = "443"

    source_address_prefix = "*"

    destination_address_prefix = "*"

  }

  tags = local.common_tags

}

resource "azurerm_network_security_group" "database" {

  name = "${local.resource_prefix}-postgres-nsg"

  location = azurerm_resource_group.main.location

  resource_group_name = azurerm_resource_group.main.name

  tags = local.common_tags

}

resource "azurerm_subnet_network_security_group_association" "container_apps" {

  subnet_id = azurerm_subnet.container_apps.id

  network_security_group_id = azurerm_network_security_group.container_apps.id

}

resource "azurerm_subnet_network_security_group_association" "database" {

  subnet_id = azurerm_subnet.database.id

  network_security_group_id = azurerm_network_security_group.database.id

}
