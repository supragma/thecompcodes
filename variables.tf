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

variable "POSTGRES_USER" { type = string }
variable "POSTGRES_PASSWORD" { type = string }
variable "POSTGRES_DB" { type = string }
variable "HOST_PATH" { type = string }