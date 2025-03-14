variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location for all resources."
}

variable "prefix" {
  type        = string
  default     = "apiops"
  description = "Prefix of the resource group name that's combined with a random value so name is unique in your Azure subscription."
}

variable "publisher_email" {
  default     = "test@contoso.com"
  description = "The email address of the owner of the service"
  type        = string
  validation {
    condition     = length(var.publisher_email) > 0
    error_message = "The publisher_email must contain at least one character."
  }
}

variable "publisher_name" {
  default     = "publisher"
  description = "The name of the owner of the service"
  type        = string
  validation {
    condition     = length(var.publisher_name) > 0
    error_message = "The publisher_name must contain at least one character."
  }
}

variable "sku" {
  description = "The pricing tier of this API Management service"
  default     = "Developer"
  type        = string
  validation {
    condition     = contains(["Consumption", "Developer", "Basic", "Standard", "Premium"], var.sku)
    error_message = "The sku must be one of the following: Developer, Standard, Premium."
  }
}

variable "sku_count" {
  description = "The instance size of this API Management service."
  default     = 1
  type        = number
  validation {
    condition     = contains([0, 1, 2], var.sku_count)
    error_message = "The sku_count must be one of the following: 0, 1, 2."
  }
}

variable "dns_subscription_id" {
  description = "The ID of the subscription containing the Public DNS for the Containers"
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the public DNS zone."
  type        = string
}

variable "dns_resource_group_name" {
  description = "The name of the resource group containing the public DNS zone."
  type        = string
}