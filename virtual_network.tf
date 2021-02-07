resource "azurerm_virtual_network" "estf" {
  name                = "${random_id.azurerm_random_id.hex}-network"
  address_space       = ["10.0.0.0/24"]
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform.name
}
