variable "project_id" {
  description = "ID projektu GCP"
  type        = string
}

variable "region" {
  description = "Region GCP"
  type        = string
}

variable "credentials" {
  description = "Credentials"
  type        = string
  sensitive   = true
}
