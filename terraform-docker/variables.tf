variable "env" {
    default = "dev"
    description = "env to deploy to"
}

variable "image" {
    type = map
    description = "image for container"
    default = {
        dev = "nodered/node-red:latest"
        prod = "nodered/node-red:latest-minimal"
    }
}

variable "ext_port" {
    type = map
}

variable "container_count" {
    type = number
    default = 2
}