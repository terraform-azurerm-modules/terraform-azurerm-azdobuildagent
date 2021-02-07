terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.44.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.6.0"
    }
  }
}
