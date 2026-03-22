
resource "google_container_cluster" "primary" {
  name     = "${var.env_name}-cluster"
  location = var.zone

  # We delete the default node pool to use a custom one
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.vpc_id
  subnetwork               = var.subnet_id

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

# The Node Pool (The Workers)
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.env_name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = true # Saves money for dev projects
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}