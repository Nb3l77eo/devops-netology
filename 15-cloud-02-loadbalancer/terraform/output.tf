
output "Manage_node" {
  value = yandex_compute_instance.mgmt-node.network_interface.0.nat_ip_address
}

output "Network_load_balancer_external_IP" {
  value = yandex_lb_network_load_balancer.lb_nlb.listener.*.external_address_spec[0].*.address
}

output "Application_load_balancer_external_IP" {
  value = yandex_alb_load_balancer.alb-test-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
