#TODO: Create build definitions once repo is populated
#region project
resource "azuredevops_project" "this" {
  name               = "apiops"
  work_item_template = "Basic"
  version_control    = "Git"
  visibility         = "private"
  description        = "Managed by Terraform"

  features = {
    "repositories" = "enabled"
    "pipelines"    = "enabled"
    "artifacts"    = "enabled"
    "testplans"    = "disabled"
    "boards"       = "disabled"
  }
}
#endregion

#region service connection
# TODO: We should really use Workload identity federation instead 
resource "azuredevops_serviceendpoint_azurerm" "this" {
  project_id                             = azuredevops_project.this.id
  service_endpoint_name                  = "APIOps_Lab"
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = "ServicePrincipal"

  credentials {
    serviceprincipalid  = azuread_service_principal.apiops.client_id
    serviceprincipalkey = azuread_service_principal_password.apiops.value
  }

  azurerm_spn_tenantid      = data.azurerm_subscription.current.tenant_id
  azurerm_subscription_id   = data.azurerm_subscription.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}
#endregion
