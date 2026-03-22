
variable "region" { default = "us-central1" }
variable "env_name" { default = "dev" }
variable "zone" { default = "us-central1-a" }

variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}