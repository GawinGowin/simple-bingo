resource "google_compute_security_policy" "policy" {
  name = var.pipecd_gcp_settings.policy_name
	description = "created_by: araki"
	type = "CLOUD_ARMOR"
  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default rule, higher priority overrides it"
  }
  rule {
    action   = "allow"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = [for host in var.allowed_hosts : host.cidr_block]
      }
    }
    description = "allow-manager-ip"
  }
}
