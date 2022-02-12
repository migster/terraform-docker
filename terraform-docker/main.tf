
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "null_resource" "docker_vol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol"
  }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count   = 1
  length  = 4
  special = false
}

resource "docker_container" "nodered_container" {
  count = 1
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 2000
    # external = var.ext_port
  }
  volumes {
    container_path = "/data"
    host_path = "/home/ubuntu/environment/terraform-docker/noderedvol"
  }
}

output "IP-Address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "This ip address and external port of the container"
}

output "Container-Name" {
  value       = docker_container.nodered_container[*].name
  description = "The name of the container"
}