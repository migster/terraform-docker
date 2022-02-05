
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1880
  }
}
    
output "IP-Address" {
  value = docker_container.nodered_container.ip_address
  description = "This ip address of the container"
}

output "Container-Name" {
  value = docker_container.nodered_container.name
  description = "The name of the container"
}