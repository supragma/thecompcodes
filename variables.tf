variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-a"
}

variable "project_name" {
  description = "Comp code project name"
  default     = "comp-code"
}

variable "SECRET_KEY_BASE" { type = string }
variable "POSTGRES_HOST" { type = string }
variable "POSTGRES_USER" { type = string }
variable "POSTGRES_PASSWORD" { type = string }
variable "POSTGRES_DB" { type = string }
variable "HOST_PATH" { type = string }
variable "RAILS_ENV" { type = string }
