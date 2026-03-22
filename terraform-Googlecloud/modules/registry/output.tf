
output "repo_url" {
  value = "${var.region}-docker.pkg.dev"
}
output "pusher_email" {
  value = google_service_account.github_pusher.email
}


output "pusher_sa_id" {
  description = "The fully qualified name of the service account"
  value       = google_service_account.github_pusher.name
}

