
resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "${var.env_name}-github-pool"
  display_name              = "GitHub Actions Pool"
}





resource "google_service_account_iam_member" "workload_identity_user" {
  service_account_id = var.service_account_id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_repo}"
}


resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  
attribute_condition = "attribute.repository == 'rukevweubio/01-Devops-Dockerswarm'" 

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}