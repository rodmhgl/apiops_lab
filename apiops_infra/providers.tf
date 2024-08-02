terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
provider "azurerm" {
  features {
    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = false
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurerm" {
  alias           = "dns"
  subscription_id = var.dns_subscription_id
  features {}
}