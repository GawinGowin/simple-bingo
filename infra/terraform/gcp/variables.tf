data "google_client_config" "default" {}

variable "cluster_name" {
	default = "example-cluster"
}

variable "instance_config" {
  description = "Node pool configuration enables only one of preemptible and spot to be enabled at a time."
  type = object({
    instance_type = string
    spot = bool
    preemptible = bool
  })
  default = {
    instance_type = "e2-standard-2"
    spot = true
    preemptible = false
  }
}

variable "allowed_hosts" {
  description = "The map of allowed hosts"
  type        = list(map(string))
  default     = [
    {
      cidr_block = "159.28.65.14/32"
      display_name = "3-shake-VPN"
    },
    {
      cidr_block = "160.237.148.66/32"
      display_name = "home-VPN"
    },
    {
      cidr_block = "111.108.92.133/32"
      display_name = "school-VPN"
    }
  ]
}

variable "pipecd_gcp_settings" {
  description = "values for pipecd & loadbalancing settings"
	type = object({
		policy_name = string
		reserve_static_external_ip_address_name = string
	})
	default = {
		policy_name = "pipecd-access-policy"
		reserve_static_external_ip_address_name = "pipecd-ip"
	}
}
