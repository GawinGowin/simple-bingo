module "gcp" {
  source = "./gcp"
}

output "project_name" {
  value = data.google_client_config.default.project
}

output "project_number" {
  value = data.google_project.project.number
}

