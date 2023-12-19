data "google_client_config" "default" {}
data "google_project" "project" {}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
    }
  }
}

provider "google" {
  project = "sreake-intern"
  default_labels = {
    tool = "terraform"
    created_by = "araki"
  }
}

provider "kubernetes" {
  host                   = "https://${module.gcp.cluster_configs.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gcp.cluster_configs.ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gcp.cluster_configs.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gcp.cluster_configs.ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command = "gcloud"
      args = [
        "container", "clusters",
        "get-credentials", module.gcp.cluster_configs.name,
        "--region", module.gcp.cluster_configs.region,
        "--project", data.google_client_config.default.project
      ]
    }
  }
}