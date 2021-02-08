# Azure container instance for the build agent
resource "azurerm_container_group" "buildagent" {
  name                = var.container_group_name
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform.name
  ip_address_type     = "Private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.aci.id

  depends_on = [azurerm_private_endpoint.acr_endpoint]

  image_registry_credential {
    server   = azurerm_container_registry.tfbuildagents.login_server
    password = azurerm_container_registry.tfbuildagents.admin_password
    username = azurerm_container_registry.tfbuildagents.admin_username
  }

  container {
    name   = "estfbuildagent"
    image  = "${azurerm_container_registry.tfbuildagents.name}.azurecr.io/${var.container_image_name}"
    cpu    = "2.0"
    memory = "4"

    # TODO Seems to be bug whereby there needs to be at least one port :(
    ports {
      port     = 23134
      protocol = "UDP"
    }

    environment_variables = {
      "AZP_URL"        = var.azuredevops_url
      "AZP_POOL"       = "terraform-${var.environment}"
      "AZP_AGENT_NAME" = "aci${random_id.azurerm_random_id.hex}"
    }

    secure_environment_variables = {
      "AZP_TOKEN" = var.azuredevops_token
    }
  }
}

resource "azurerm_network_profile" "aci" {
  name                = "${var.container_group_name}networkprofile"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform.name

  container_network_interface {
    name = "acinic${random_id.azurerm_random_id.hex}"

    ip_configuration {
      name      = "acinicip${random_id.azurerm_random_id.hex}"
      subnet_id = azurerm_subnet.estfaci.id
    }
  }
}
