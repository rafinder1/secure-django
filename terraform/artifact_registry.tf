resource "google_artifact_registry_repository" "app_repo" {
  provider = google
  location = var.region
  repository_id = "app-container-repo"
  description = "Container repo for app images"
  format = "DOCKER"
}