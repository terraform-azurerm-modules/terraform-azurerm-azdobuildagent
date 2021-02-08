variable "azuredevops_token" {
  type        = string
  description = "Azure DevOps Personal Access Token, used only to set up the initial agent communication"
  sensitive   = true
}

variable "azuredevops_url" {
  type        = string
  description = "URL for the Azure DevOps org, e.g. https://dev.azure.com/myorg"
}

variable "build_agent_repo_source_url" {
  type        = string
  default     = "https://github.com/terraform-azurerm-examples/terraform-azuredevops-buildagent.git"
  description = "Source URL for build agent Docker files"
}

variable "container_group_name" {
  type    = string
  default = "estfbuildagent"
}

variable "container_image_name" {
  type    = string
  default = "eslz/buildagent:main"
}

variable "container_registry_prefix" {
  type    = string
  default = "eslztf"
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "Environment, e.g. 'prod' or 'canary'"
}

variable "key_vault_prefix" {
  type        = string
  default     = "estf"
  description = "Location of Azure resources"
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "Location of Azure resources"
}

variable "storage_account_prefix" {
  type        = string
  default     = "estf"
  description = "Location of Azure resources"
}
