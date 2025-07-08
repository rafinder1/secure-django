terraform {
  backend "gcs" {
    bucket = "geoteko-hub-terraform-state-prod"
    prefix = "terraform/state"
  }
}
