

resource "docker_image" "db" {
  name = "postgres:10"
  keep_locally = false
}

resource "docker_container" "comp_code" {
  image = "comp_code:latest"
  name  = "comp_code"
  restart = "always"
  volumes {
    container_path  = "/myapp"
    host_path = "/Users/belwasetech/projects/supragma/comp.code"
    read_only = false
  }
  ports {
    internal = 3000
    external = 3000
  }
}

resource "docker_container" "db" {
  image  = docker_image.db.latest
  name = "comp_code_postgres"
  restart = "always"
  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=toor",
    "POSTGRES_DB=comp_code"
  ]
  ports {
    internal = 5432
    external = 5434
  }
}

