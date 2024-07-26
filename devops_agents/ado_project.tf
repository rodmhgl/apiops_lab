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
resource "azuredevops_serviceendpoint_azurerm" "this" {
  project_id                             = azuredevops_project.this.id
  service_endpoint_name                  = "APIOps_Lab"
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = "WorkloadIdentityFederation"

  credentials {
    serviceprincipalid = azurerm_user_assigned_identity.agent.client_id
  }

  azurerm_spn_tenantid      = data.azurerm_subscription.current.tenant_id
  azurerm_subscription_id   = data.azurerm_subscription.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}
#endregion
