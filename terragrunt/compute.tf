resource "openstack_compute_instance_v2" "min_scale_jumper" {
  name       = "min_scale_jumper"
  image_id   = "fd234366-75b1-47a1-b8ce-e9f9859b50b0"
  flavor_id  = data.openstack_compute_flavor_v2.d2-4.id
  key_pair   = "cyberrange-key"
  depends_on = [openstack_networking_subnet_v2.min_scale_subnet, openstack_networking_port_v2.min_scale_port]
  network {
    uuid = openstack_networking_network_v2.min_scale_network.id
    port = openstack_networking_port_v2.min_scale_port.id
  }
}

resource "openstack_compute_instance_v2" "min_scale_client" {
  count      = 3
  name       = "min_scale_client.${count.index}"
  image_id   = "fd234366-75b1-47a1-b8ce-e9f9859b50b0"
  flavor_id  = data.openstack_compute_flavor_v2.d2-4.id
  key_pair   = "cyberrange-key"
  depends_on = [openstack_networking_subnet_v2.min_scale_subnet]
  network {
    uuid = openstack_networking_network_v2.min_scale_network.id
  }
}