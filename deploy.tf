
resource "docker_image" "db" {
  name         = "postgres:10"
  keep_locally = false
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_network" "private_network" {
  name = "comp_code_network"
}

resource "docker_container" "db" {
  image   = docker_image.db.latest
  name    = "comp_code_postgres"
  restart = "always"
  env = [
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_DB=${var.POSTGRES_DB}"
  ]
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.private_network.name
  }
  ports {
    internal = 5432
    external = 5432
  }
}

resource "docker_container" "nginx" {
  image        = docker_image.nginx.latest
  name         = "comp_code_nginx"
  restart      = "always"
  network_mode = "bridge"
  volumes {
    container_path  = "/etc/nginx/conf.d"
    host_path = "${var.HOST_PATH}/config/nginx"
    read_only = false
  }
  volumes {
    container_path  = "/etc/certs"
    host_path = "${var.HOST_PATH}/config/nginx/certs"
    read_only = false
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  ports {
    internal = 443
    external = 443
  }
}


resource "docker_container" "comp_code" {
  image   = "comp_code:latest"
  name    = "comp_code"
  restart = "always"
  volumes {
    container_path = "/myapp"
    host_path      = var.HOST_PATH
    read_only      = false
  }
  network_mode = "bridge"
  networks_advanced {
    name = docker_network.private_network.name
  }
  ports {
    internal = 3000
    external = 3000
  }
}
