resource "azurerm_virtual_network" "main" {

  name = "${local.resource_prefix}-vnet"

  location = azurerm_resource_group.main.location

  resource_group_name = azurerm_resource_group.main.name

  address_space = [
    "10.0.0.0/16"
  ]

  tags = local.common_tags

}

resource "azurerm_subnet" "container_apps" {

  name = "containerapps-subnet"

  resource_group_name = azurerm_resource_group.main.name

  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = [
    "10.0.1.0/24"
  ]

  delegation {

    name = "aca-delegation"

    service_delegation {

      name = "Microsoft.App/environments"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]

    }

  }

}

resource "azurerm_subnet" "database" {

  name = "postgres-subnet"

  resource_group_name = azurerm_resource_group.main.name

  virtual_network_name = azurerm_virtual_network.main.name

  address_prefixes = [
    "10.0.2.0/24"
  ]

  delegation {

    name = "postgres-delegation"

    service_delegation {

      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]

    }

  }

}
