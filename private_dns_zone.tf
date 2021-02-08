// Storage
resource "azurerm_private_dns_zone" "storage" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.terraform.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage" {
  name                  = "estf"
  resource_group_name   = azurerm_resource_group.terraform.name
  private_dns_zone_name = azurerm_private_dns_zone.storage.name
  virtual_network_id    = azurerm_virtual_network.estf.id
}

// KeyVault
resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.terraform.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "keyvault" {
  name                  = "estf"
  resource_group_name   = azurerm_resource_group.terraform.name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = azurerm_virtual_network.estf.id
}

// ACR
resource "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.terraform.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr" {
  name                  = "estf"
  resource_group_name   = azurerm_resource_group.terraform.name
  private_dns_zone_name = azurerm_private_dns_zone.acr.name
  virtual_network_id    = azurerm_virtual_network.estf.id
}