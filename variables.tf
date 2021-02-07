variable "build_agent_repo_source_url" {
  type    = string
  default = "https://github.com/terraform-azurerm-examples/terraform-azuredevops-buildagent.git"
  description = "Source URL for build agent Docker files"
}

variable "environment" {
  type    = string
  default = "prod"
  description = "Environment, e.g. 'prod' or 'canary'"
}

variable "key_vault_prefix" {
  type = string
  default = "estf"
  description = "Location of Azure resources"
}

variable "location" {
  type = string
  default = "westeurope"
  description = "Location of Azure resources"
}

variable "storage_account_prefix" {
  type = string
  default = "estf"
  description = "Location of Azure resources"
}
