resource "azurerm_resource_group" "main" {

  name     = "${local.resource_prefix}-rg"
  location = var.location

  tags = local.common_tags

}
