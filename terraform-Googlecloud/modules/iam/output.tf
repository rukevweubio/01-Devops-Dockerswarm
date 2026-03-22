output "provider_name" {
  description = "The full identifier of the Workload Identity Provider"

  value       = google_iam_workload_identity_pool_provider.github_provider.name
}