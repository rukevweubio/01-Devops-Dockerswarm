resource "google_compute_network" "main" {
  name                    = "${var.env_name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name          = "${var.env_name}-subnet"
  ip_cidr_range = "10.0.0.0/18"
  region        = var.region
  network       = google_compute_network.main.id
  
  # Required for Private GKE clusters & Workload Identity
  private_ip_google_access = true
}