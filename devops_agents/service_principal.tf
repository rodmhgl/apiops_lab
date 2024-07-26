
resource "azuread_application_registration" "apiops" {
  display_name = "sp-apiops-lab"
}

resource "azurerm_federated_identity_credential" "apiops" {
  name                = "apiops-federated-credential"
  resource_group_name = azurerm_resource_group.main.name
  parent_id           = azurerm_user_assigned_identity.agent.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azuredevops_serviceendpoint_azurerm.this.workload_identity_federation_issuer
  subject             = azuredevops_serviceendpoint_azurerm.this.workload_identity_federation_subject
}

resource "azurerm_role_assignment" "apiops" {
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.agent.principal_id
  scope                = data.azurerm_subscription.current.id
}
