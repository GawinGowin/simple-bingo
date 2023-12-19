data "google_client_config" "default" {}
data "google_project" "project" {}

provider "google" {
  project     = "sreake-intern"
}

output "project" {
  value = data.google_client_config.default.project
}

output "project_number" {
  value = data.google_project.project.number
}
