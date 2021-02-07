resource "azurerm_subnet" "estf" {
  name                 = "${random_id.azurerm_random_id.hex}-subnet"
  resource_group_name  = azurerm_resource_group.terraform.name
  virtual_network_name = azurerm_virtual_network.estf.name
  address_prefixes     = ["10.0.0.0/25"]
  service_endpoints = [
    "Microsoft.KeyVault",
    "Microsoft.Storage"
  ]

  enforce_private_link_endpoint_network_policies = true
}
