// Storage account for the Terraform backend
resource "azurerm_storage_account" "backend" {
  name                      = "${var.storage_account_prefix}${random_id.azurerm_random_id.hex}"
  resource_group_name       = azurerm_resource_group.terraform.name
  location                  = var.location
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  /*   network_rules {
    default_action             = "Allow"
    bypass                     = ["None"]
    virtual_network_subnet_ids = [azurerm_subnet.estf.id]
  } */
}

resource "azurerm_private_endpoint" "backend_endpoint" {
  name                = "${var.storage_account_prefix}${random_id.azurerm_random_id.hex}-stoendpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform.name
  subnet_id           = azurerm_subnet.estf.id
  private_dns_zone_group {
    name                 = "estf"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage.id]
  }

  private_service_connection {
    name                           = "${var.storage_account_prefix}${random_id.azurerm_random_id.hex}-stoserviceconnection"
    private_connection_resource_id = azurerm_storage_account.backend.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
