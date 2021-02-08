resource "azurerm_subnet" "estf" {
  name                 = "${random_id.azurerm_random_id.hex}-subnet"
  resource_group_name  = azurerm_resource_group.terraform.name
  virtual_network_name = azurerm_virtual_network.estf.name
  address_prefixes     = ["10.0.0.0/25"]
  service_endpoints = [
    "Microsoft.KeyVault",
    "Microsoft.Storage",
    "Microsoft.ContainerRegistry"
  ]

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "estfaci" {
  name                 = "${random_id.azurerm_random_id.hex}-subnet2"
  resource_group_name  = azurerm_resource_group.terraform.name
  virtual_network_name = azurerm_virtual_network.estf.name
  address_prefixes     = ["10.0.0.128/25"]
  delegation {
    name = "aci"
    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }
  enforce_private_link_endpoint_network_policies = true

}
