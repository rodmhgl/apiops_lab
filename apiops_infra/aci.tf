module "colours_api_containers" {
  source   = "./modules/aci"
  for_each = toset(local.environments)

  container_group_name = module.naming[each.key].container_group.name
  container_app_name   = module.naming[each.key].container_app.name
  location             = azurerm_resource_group.this[each.key].location
  resource_group_name  = azurerm_resource_group.this[each.key].name
}

data "azurerm_dns_zone" "public" {
  provider = azurerm.dns

  name                = var.dns_zone_name
  resource_group_name = var.dns_resource_group_name
}

resource "azurerm_dns_a_record" "web" {
  provider = azurerm.dns
  for_each = toset(local.environments)

  name                = "colors-web-${each.key}"
  zone_name           = data.azurerm_dns_zone.public.name
  resource_group_name = data.azurerm_dns_zone.public.resource_group_name
  ttl                 = 60
  records             = [module.colours_api_containers[each.key].web_container_ipv4_address]
}

resource "azurerm_dns_a_record" "api" {
  provider = azurerm.dns
  for_each = toset(local.environments)

  name                = "colors-api-${each.key}"
  zone_name           = data.azurerm_dns_zone.public.name
  resource_group_name = data.azurerm_dns_zone.public.resource_group_name
  ttl                 = 60
  records             = [module.colours_api_containers[each.key].api_container_ipv4_address]
}

