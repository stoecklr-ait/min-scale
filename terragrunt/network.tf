resource "openstack_networking_network_v2" "min_scale_network" {
  name                  = "min_scale_network"
  admin_state_up        = "true"
  port_security_enabled = false
}

resource "openstack_networking_subnet_v2" "min_scale_subnet" {
  name       = "min_scale_subnet"
  network_id = openstack_networking_network_v2.min_scale_network.id
  cidr       = "10.199.0.0/16"
}

resource "openstack_networking_router_interface_v2" "min_scale_router_int" {
  router_id = data.openstack_networking_router_v2.stoecklr-router.id
  subnet_id = openstack_networking_subnet_v2.min_scale_subnet.id
}

resource "openstack_networking_floatingip_v2" "min_scale_float" {
  description = "min_scale_float"
  pool        = data.openstack_networking_network_v2.CBT-DEV-provider.name
}

resource "openstack_networking_port_v2" "min_scale_port" {
  name                  = "min_scale_port"
  network_id            = openstack_networking_network_v2.min_scale_network.id
  admin_state_up        = true
  port_security_enabled = false

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.min_scale_subnet.id
  }
}

resource "openstack_networking_floatingip_associate_v2" "min_scale_fipa" {
  floating_ip = openstack_networking_floatingip_v2.min_scale_float.address
  port_id     = openstack_networking_port_v2.min_scale_port.id
}