output "Manage_node_EXT_IP" {
  value = yandex_compute_instance.mgmt-node.network_interface.0.nat_ip_address
}


output "phpMyadmin_EXT_IP" {
  value = data.template_file.ext_ip_lb.rendered
}