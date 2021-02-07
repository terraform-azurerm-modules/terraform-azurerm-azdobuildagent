// Key Vault for pipeline secrets
resource "azurerm_key_vault" "terraform" {
  name                        = "${var.key_vault_prefix}${random_id.azurerm_random_id.hex}"
  location                    = azurerm_resource_group.terraform.location
  resource_group_name         = azurerm_resource_group.terraform.name
  enabled_for_disk_encryption = false
  enable_rbac_authorization   = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "None"
  }
}

resource "azurerm_private_endpoint" "keyvault_endpoint" {
  name                = "${var.key_vault_prefix}${random_id.azurerm_random_id.hex}-kvendpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform.name
  subnet_id           = azurerm_subnet.estf.id
  private_dns_zone_group {
    name                 = "vault"
    private_dns_zone_ids = [azurerm_private_dns_zone.keyvault.id]
  }

  private_service_connection {
    name                           = "${var.key_vault_prefix}${random_id.azurerm_random_id.hex}-kvserviceconnection"
    private_connection_resource_id = azurerm_key_vault.terraform.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}
