module "gcp" {
  source = "./gcp"
}

module "argocd" {
  source = "../chart/argocd"
  namespace = "argocd"
  depends_on = [ module.gcp ]
}

# module "pipecd" {
#   source = "../chart/pipecd"
#   namespace = "pipecd"
#   depends_on = [ module.gcp ]
# }

module "pipecd_local" {
  source = "../chart/pipecd_local"
  namespace = "pipecd-local"
  depends_on = [ module.gcp ]
}

output "project_name" {
  value = data.google_client_config.default.project
}

output "project_number" {
  value = data.google_project.project.number
}

