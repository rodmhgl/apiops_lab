terraform {
  required_version = ">= 1.6.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.112.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "1.1.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1"
    }
  }
}

provider "random" {}
provider "local" {}
provider "azuread" {}

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url       = local.ado_url
  personal_access_token = var.ado_token
}
