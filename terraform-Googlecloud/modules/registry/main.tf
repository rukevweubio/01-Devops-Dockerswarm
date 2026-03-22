
resource "google_artifact_registry_repository" "app_repo" {
  location      = var.region
  repository_id = "${var.env_name}-repo"
  description   = "Docker repository for ${var.env_name} apps"
  format        = "DOCKER"
}


resource "google_service_account" "github_pusher" {
  account_id   = "github-pusher-sa"
  display_name = "Service Account for GitHub Actions to push images"
}


resource "google_artifact_registry_repository_iam_member" "pusher_iam" {
  location   = google_artifact_registry_repository.app_repo.location
  repository = google_artifact_registry_repository.app_repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.github_pusher.email}"
}