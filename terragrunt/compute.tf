resource "openstack_compute_instance_v2" "min_scale_jumper" {
  name       = "min_scale_jumper"
  tags       = ["min_scale_jumper", "min_scale_comp"]
  image_id   = "fd234366-75b1-47a1-b8ce-e9f9859b50b0"
  flavor_id  = data.openstack_compute_flavor_v2.weak.id
  key_pair   = "cyberrange-key"
  depends_on = [openstack_networking_subnet_v2.min_scale_subnet, openstack_networking_port_v2.min_scale_port]
  network {
    uuid = openstack_networking_network_v2.min_scale_network.id
    port = openstack_networking_port_v2.min_scale_port.id
  }
}

resource "openstack_compute_instance_v2" "min_scale_client" {
  count      = 10
  name       = "min_scale_client.${count.index}"
  tags       = ["min_scale_client", "min_scale_comp"]
  image_id   = data.openstack_images_image_v2.ubuntu.id
  flavor_id  = data.openstack_compute_flavor_v2.weak.id
  key_pair   = "cyberrange-key"
  depends_on = [openstack_networking_subnet_v2.min_scale_subnet]
  network {
    uuid = openstack_networking_network_v2.min_scale_network.id
  }
}
