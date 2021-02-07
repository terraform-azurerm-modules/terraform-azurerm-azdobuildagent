# The resource group for the whole shebang
resource "azurerm_resource_group" "terraform" {
  name     = "estf-${var.environment}"
  location = var.location
}
