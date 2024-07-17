output "api_container_ipv4_address" {
  value = azurerm_container_group.colours_api.ip_address
}

output "web_container_ipv4_address" {
  value = azurerm_container_group.colours_web.ip_address
}
