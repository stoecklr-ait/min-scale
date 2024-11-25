terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "openstack" {
}

data "openstack_compute_flavor_v2" "d2-4" {
  vcpus = 2
  ram   = 4096
}

data "openstack_networking_network_v2" "CBT-DEV-provider" {
  name = "CBT-DEV-provider-network"
}

data "openstack_networking_router_v2" "stoecklr-router" {
  name = "stoecklr-router"
}


output "floating_ip_address" {
  value = openstack_networking_floatingip_v2.min_scale_float.address
}

output "jumper_ip_address" {
  value = openstack_compute_instance_v2.min_scale_jumper.access_ip_v4
}

output "client_ip_addresses" {
  value = openstack_compute_instance_v2.min_scale_client[*].access_ip_v4
}
