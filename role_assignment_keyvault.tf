// Role assignment using user assigned identity to allow the ACI to read secrets
// Currently using Key Vault Azure RBAC
resource "azurerm_role_assignment" "key_vault_spn" {
  scope                = azurerm_key_vault.terraform.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_service_principal.estf.object_id
}

// Kay Vault permission to allow current user to manage blobs
// Used to upload secrets for backend
// Remove once complete
resource "azurerm_role_assignment" "key_vault_admin" {
  scope                = azurerm_key_vault.terraform.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azuread_service_principal.estf.object_id
}
