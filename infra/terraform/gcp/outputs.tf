output "cluster_configs" {
  description = "This parameter is used for top level providers"
  value = {
    name = google_container_cluster.primary.name
    region = google_container_cluster.primary.location
    endpoint = google_container_cluster.primary.endpoint
    ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  }
}

output "loadbalancer_settings" {
  description = "This parameter provided for loadbalancer settings"
  value = {
    alocated_ip = google_compute_global_address.pipecd_ip.address
    policy_name = google_compute_security_policy.policy.name
  }
}
