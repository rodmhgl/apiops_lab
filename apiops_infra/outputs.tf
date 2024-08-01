output "api_container_ipv4_address" {
  value = { for k, v in module.colours_api_containers : k => v.api_container_ipv4_address }
}

output "web_container_ipv4_address" {
  value = { for k, v in module.colours_api_containers : k => v.web_container_ipv4_address }
}

output "resource_group_name" {
  value = { for k, v in azurerm_resource_group.this : k => v.name }
}

output "api_management_service_name" {
  value = { for k, v in azurerm_api_management.this : k => v.name }
}

output "api_management_gateway_url" {
  value = { for k, v in azurerm_api_management.this : k => v.gateway_url }
}

output "web_container_dns_name" {
  value = { for k, v in azurerm_dns_a_record.web : k => "http://${v.fqdn}" }
}

output "api_container_dns_name" {
  value = { for k, v in azurerm_dns_a_record.api : k => "http://${v.fqdn}" }
}