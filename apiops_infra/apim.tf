# #TODO: Import API
# #TODO: Disable subscription key requirement
# #TODO: Templatize backend? 
resource "azurerm_api_management" "this" {
  for_each = toset(local.environments)

  name                = "${module.naming[each.key].api_management.name}lab"
  location            = azurerm_resource_group.this[each.key].location
  resource_group_name = azurerm_resource_group.this[each.key].name
  publisher_email     = var.publisher_email
  publisher_name      = var.publisher_name
  sku_name            = "${var.sku}_${var.sku_count}"
}
