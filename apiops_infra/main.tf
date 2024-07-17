locals {
  environments = ["dev", "prd"]
}

module "naming" {
  source   = "Azure/naming/azurerm"
  version  = "0.4.1"
  for_each = toset(local.environments)

  prefix = [var.prefix, each.key]
}

resource "azurerm_resource_group" "this" {
  for_each = toset(local.environments)

  name     = module.naming[each.key].resource_group.name
  location = var.resource_group_location
}
