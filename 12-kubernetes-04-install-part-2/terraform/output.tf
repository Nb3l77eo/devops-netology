output "internal_ip_address_k8s-master1" {
  value = "${yandex_compute_instance.k8s-master1.network_interface.0.ip_address}"
}

output "external_ip_address_k8s-master1" {
  value = "${yandex_compute_instance.k8s-master1.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_k8s-worker1" {
  value = "${yandex_compute_instance.k8s-worker1.network_interface.0.ip_address}"
}

output "external_ip_address_k8s-worker1" {
  value = "${yandex_compute_instance.k8s-worker1.network_interface.0.nat_ip_address}"
}

output "external_ip_address_k8s-worker2" {
  value = "${yandex_compute_instance.k8s-worker2.network_interface.0.nat_ip_address}"
}

output "external_ip_address_k8s-worker3" {
  value = "${yandex_compute_instance.k8s-worker3.network_interface.0.nat_ip_address}"
}

output "external_ip_address_k8s-worker4" {
  value = "${yandex_compute_instance.k8s-worker4.network_interface.0.nat_ip_address}"
}


