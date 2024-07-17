module "colours_api_containers" {
  source   = "./modules/aci"
  for_each = toset(local.environments)

  container_group_name = module.naming[each.key].container_group.name
  container_app_name   = module.naming[each.key].container_app.name
  location             = azurerm_resource_group.this[each.key].location
  resource_group_name  = azurerm_resource_group.this[each.key].name
}
