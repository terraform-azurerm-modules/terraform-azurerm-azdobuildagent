# Container registry to store the container images
# Currently needs admin access enabled as we cannot use managed identity during creation (platform limitation - same in portal)
resource "azurerm_container_registry" "tfbuildagents" {
  name                = "${var.container_registry_prefix}${random_id.azurerm_random_id.hex}"
  resource_group_name = azurerm_resource_group.terraform.name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true # TODO we need this for ACI at creation time :(
}

resource "azurerm_private_endpoint" "acr_endpoint" {
  name                = "${var.storage_account_prefix}${random_id.azurerm_random_id.hex}-acrendpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform.name
  subnet_id           = azurerm_subnet.estf.id
  private_dns_zone_group {
    name                 = "estf"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr.id]
  }

  private_service_connection {
    name                           = "${var.storage_account_prefix}${random_id.azurerm_random_id.hex}-acrserviceconnection"
    private_connection_resource_id = azurerm_container_registry.tfbuildagents.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
}


# Local-exec provisioner to stand up the initial container image
# ...Sleep 60 due to Azure timing issue when provisioning with TF
# Future agent builds will be managed using Azure pipelines, see the aci build definition
# Build will take approx 5-6 mins
resource "null_resource" "azure_container_registry_build_task" {
  depends_on = [azurerm_container_registry.tfbuildagents]
  provisioner "local-exec" {
    command = "az acr build -t ${var.container_image_name} -r ${azurerm_container_registry.tfbuildagents.name} --no-logs ${var.build_agent_repo_source_url} && sleep 60"
  }
}
