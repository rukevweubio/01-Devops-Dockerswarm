
module "network" {
  source   = "./modules/network"
  env_name = var.env_name
  region   = var.region
}


module "compute" {
  source     = "./modules/compute"
  project_id = var.project_id
  region     = var.region
  zone       = "${var.region}-a"
  env_name   = var.env_name
  vpc_id     = module.network.vpc_id
  subnet_id  = module.network.subnet_id

}


module "registry" {
  source   = "./modules/registry"
  env_name = var.env_name
  region   = var.region
}


module "github_iam" {
  source             = "./modules/iam"
  env_name           = var.env_name
  github_repo        = "rukevweubio/01-Devops-Dockerswarm"
  service_account_id = module.registry.pusher_sa_id # References output from registry module
}




data "google_project" "project" {}

resource "google_project_iam_member" "gke_puller" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

