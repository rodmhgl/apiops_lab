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
#TODO: create app registration as part of this to avoid passing vars
resource "azuredevops_serviceendpoint_azurerm" "this" {
  project_id                             = azuredevops_project.this.id
  service_endpoint_name                  = "APIOps_Lab"
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = "ServicePrincipal"

  credentials {
    serviceprincipalid  = var.azurerm_serviceprincipal_id
    serviceprincipalkey = var.azurerm_serviceprincipal_key
  }

  azurerm_spn_tenantid      = var.azurerm_spn_tenantid
  azurerm_subscription_id   = var.azurerm_subscription_id
  azurerm_subscription_name = var.azurerm_subscription_name
}
#endregion
