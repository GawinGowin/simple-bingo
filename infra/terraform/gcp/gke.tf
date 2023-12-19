resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project = data.google_client_config.default.project
  location = "asia-northeast1"
  node_locations = ["asia-northeast1-a", "asia-northeast1-b"]

  network = google_compute_network.cluster_network.name
  subnetwork = google_compute_subnetwork.cluster_subnetwork.name

  remove_default_node_pool = true

  initial_node_count = 1
  lifecycle {
    ignore_changes = [
      initial_node_count
    ]
  }

  deletion_protection = false

  ip_allocation_policy {
    cluster_secondary_range_name = "ip-range-pods"
    services_secondary_range_name = "ip-range-services"
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = true
    cidr_blocks {
      cidr_block   = "159.28.65.14/32"
      display_name = "3-shake-VPN"
    }
    cidr_blocks {
      cidr_block   = "160.237.148.66/32"
      display_name = "home-VPN"
    }
    cidr_blocks {
      cidr_block   = "111.108.92.133/32"
      display_name = "school-VPN"
    }
  }
  resource_labels = {
    created_by = "araki"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "example-node-pool"
  project = data.google_client_config.default.project
  location   = "asia-northeast1"
  node_locations = ["asia-northeast1-a", "asia-northeast1-b"]
  cluster    = google_container_cluster.primary.name
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = var.instance_config.preemptible
    spot = var.instance_config.spot
    machine_type = var.instance_config.instance_type

    disk_size_gb = 10
    tags = [ "access-allowed-cluster" ]

    service_account = "rsakurai-ojt@sreake-intern.iam.gserviceaccount.com"
    oauth_scopes    = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    labels =  {
      created_by = "araki"
    }
  }
}
