# Create VPC Network for GKE cluster
resource "google_compute_network" "cluster_network" {
  project                 = data.google_client_config.default.project
  name                    = "example-cluster-network"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "cluster_subnetwork" {
  project       = data.google_client_config.default.project
  name          = "example-cluster-subnet"
  ip_cidr_range = "10.10.10.0/24"
  network       = google_compute_network.cluster_network.id
  region        = "asia-northeast1"

  secondary_ip_range = [
    {
      range_name = "ip-range-services"
      ip_cidr_range = "10.21.0.0/24"
    },
    {
      range_name = "ip-range-pods"
      ip_cidr_range = "10.22.0.0/21"
    },
  ]
}

#Create VPC rules
locals {
  allowed_range = [for host in var.allowed_hosts : host["cidr_block"]]
}

resource "google_compute_firewall" "cluster_firewall_controle_plane" {
  name    = "vpc-firewall-control-plane"
  project = data.google_client_config.default.project
  network = google_compute_network.cluster_network.name
  description = "This firewall is for GKE cluster by araki"

  allow {
    protocol  = "tcp"
    ports    = ["22", "80", "443"]
  }

  direction = "INGRESS"
  target_tags = ["access-allowed-cluster"]
  source_ranges = local.allowed_range
}
