

output "workload_identity_provider" {
  description = "The full identifier of the Workload Identity Provider"
  value       = module.github_iam.provider_name
}

output "artifact_registry_repo" {
  description = "The Docker repository URL"
  value       = module.registry.repo_url
}

output "github_service_account_email" {
  description = "The email of the SA GitHub will impersonate"
  value       = module.registry.pusher_email
}
 