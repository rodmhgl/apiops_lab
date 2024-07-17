variable "location" {
  type        = string
  description = "Location for Azure Resource Group."
}

variable "ado_org_name" {
  description = "Name of your Azure DevOps Organization."
  type        = string
}

variable "ado_token" {
  description = "Personal access token for your Azure DevOps Organziation."
  type        = string
}

variable "ado_pool" {
  description = "Name of the agent pool you created in Azure DevOps. If not set, a new pool named aci-agents will be created."
  type        = string
  default     = ""
}

# The default image is public, feel free to use it. 
variable "agent_image" {
  description = "Docker image for the self-hosted agent."
  type        = string
  default     = "ghcr.io/rodmhgl/azp-agent:1.5.0"
}

variable "ado_principal_name" {
  description = "Principal name of your ADO user."
  type        = string
}

variable "azurerm_serviceprincipal_id" {
  type        = string
  description = "The Service Principal ID for the AzureRM Service Connection."
}
variable "azurerm_serviceprincipal_key" {
  type        = string
  description = "The Service Principal Key for the AzureRM Service Connection."
}
variable "azurerm_spn_tenantid" {
  type        = string
  description = "The Tenant ID for the AzureRM Service Connection."
}
variable "azurerm_subscription_id" {
  type        = string
  description = "The Subscription ID for the AzureRM Service Connection."
}
variable "azurerm_subscription_name" {
  type        = string
  description = "The Subscription Name for the AzureRM Service Connection."
}

#region ADO Variable Group
variable "apim_dev_name" {
  type        = string
  description = "The name of the dev API Management resource."
  default     = "apiopsdevapimlab"
}

variable "apim_prd_name" {
  type        = string
  description = "The name of the dev API Management resource."
  default     = "apiopsprdapimlab"
}

variable "apim_dev_resource_group_name" {
  type        = string
  description = "The name of the resource containing the dev API Management resource."
  default     = "apiops-dev-rg"
}

variable "apim_prd_resource_group_name" {
  type        = string
  description = "The name of the resource containing the prod API Management resource."
  default     = "apiops-prd-rg"
}

variable "apiops_release_version" {
  type        = string
  description = "The APIOps release version to use."
  default     = "v5.1.4"
}
#endregion