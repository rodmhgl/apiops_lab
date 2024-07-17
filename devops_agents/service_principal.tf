data "azuread_client_config" "current" {}

resource "azuread_application" "apiops" {
  display_name = "sp-apiops-lab"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "apiops" {
  application_id               = azuread_application.apiops.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "apiops" {
  service_principal_id = azuread_service_principal.apiops.object_id
}

resource "azurerm_role_assignment" "apiops" {
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.apiops.id
  scope                = data.azurerm_subscription.current.id
}
