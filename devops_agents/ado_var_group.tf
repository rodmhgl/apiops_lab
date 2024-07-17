resource "azuredevops_variable_group" "apiops" {
  name       = "apim-automation"
  project_id = azuredevops_project.this.id
  variable {
    name  = "SERVICE_CONNECTION_NAME"
    value = azuredevops_serviceendpoint_azurerm.this.service_endpoint_name
  }
  variable {
    name  = "APIM_NAME"
    value = var.apim_dev_name
  }
  variable {
    name  = "APIM_NAME_Prod"
    value = var.apim_prd_name
  }
  variable {
    name  = "RESOURCE_GROUP_NAME"
    value = var.apim_dev_resource_group_name
  }
  variable {
    name  = "RESOURCE_GROUP_NAME_Prod"
    value = var.apim_prd_resource_group_name
  }
  variable {
    name  = "apiops_release_version"
    value = var.apiops_release_version
  }
}

resource "azuredevops_variable_group_permissions" "apiops" {
  project_id        = azuredevops_project.this.id
  variable_group_id = azuredevops_variable_group.apiops.id
  principal         = azuredevops_group.apiops.id
  permissions = {
    "View" : "allow",
    "Administer" : "allow",
    "Create" : "allow",
    "ViewSecrets" : "allow",
    "Use" : "allow",
    "Owner" : "allow",
  }
}