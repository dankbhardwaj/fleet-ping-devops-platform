resource "azurerm_role_assignment" "container_app_acr_pull" {

  scope = azurerm_container_registry.main.id

  role_definition_name = "AcrPull"

  principal_id = azurerm_container_app.main.identity[0].principal_id

}

resource "azurerm_role_assignment" "container_app_keyvault" {

  scope = azurerm_key_vault.main.id

  role_definition_name = "Key Vault Secrets User"

  principal_id = azurerm_container_app.main.identity[0].principal_id

}
