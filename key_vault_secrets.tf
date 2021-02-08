resource "azurerm_key_vault_secret" "arm_subscription_id" {
  name         = "arm-subscription-id"
  value        = data.azurerm_subscription.current.subscription_id
  key_vault_id = azurerm_key_vault.terraform.id
  depends_on = [ azurerm_role_assignment.key_vault_admin ]
}

resource "azurerm_key_vault_secret" "arm_tenant_id" {
  name         = "arm-tenant-id"
  value        = data.azurerm_subscription.current.tenant_id
  key_vault_id = azurerm_key_vault.terraform.id
  depends_on = [ azurerm_role_assignment.key_vault_admin ]
}

resource "azurerm_key_vault_secret" "arm_client_id" {
  name         = "arm-client-id"
  value        = azuread_application.estf.application_id
  key_vault_id = azurerm_key_vault.terraform.id
  depends_on = [ azurerm_role_assignment.key_vault_admin ]
}

resource "azurerm_key_vault_secret" "arm_client_secret" {
  name         = "arm-client-secret"
  value        = random_password.spn_password.result
  key_vault_id = azurerm_key_vault.terraform.id
  depends_on = [ azurerm_role_assignment.key_vault_admin ]
}
