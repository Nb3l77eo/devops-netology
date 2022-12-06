output "Use_this_IP_to_connect" {
  value = "${yandex_compute_instance.pubNodes[*].network_interface.0.nat_ip_address}"
}


