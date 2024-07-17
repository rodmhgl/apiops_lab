terraform {
  required_providers {
    docker = {
      source  = "calxus/docker"
      version = "3.0.0"
    }
  }
}

provider "docker" {}

variable "tag" {
  description = "Docker tag for the self-hosted agent."
  type        = string
  default     = "1.5.0"
}

resource "docker_image" "azp_agent" {
  name = "azp-agent"
  build {
    path = "."
    tag  = ["ghcr.io/rodmhgl/azp-agent:${var.tag}"]
  }
}