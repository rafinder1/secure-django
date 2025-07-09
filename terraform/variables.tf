variable "project_id" {
  description = "ID projektu GCP"
  type        = string
}

variable "region" {
  description = "Region GCP"
  type        = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
}

variable "tier" {
  type    = string
  default = "db-f1-micro"
}

variable "instance_name" {
  default = "app-cloudsql-instance"
}