resource "google_compute_global_address" "pipecd_ip" {
  name   = var.pipecd_gcp_settings.reserve_static_external_ip_address_name
	address_type = "EXTERNAL"
	description = "created_by: araki"
}
