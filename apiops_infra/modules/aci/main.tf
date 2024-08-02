resource "azurerm_container_group" "colours_api" {
  name                = "${var.container_group_name}-api"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  container {
    name   = "${var.container_app_name}-api"
    image  = strcontains(var.container_app_name, "dev") ? "${var.image_api}:blue": "${var.image_api}:green"
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }
}

resource "azurerm_container_group" "colours_web" {
  name                = "${var.container_group_name}-web"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy

  container {
    name   = "${var.container_app_name}-web"
    image  = var.image_web
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }
}
