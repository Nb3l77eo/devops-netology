resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 5"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "ping" {
  provisioner "local-exec" {
    command = <<-EOT
	ping -c 3 -W 2 ${yandex_compute_instance.k8s-master1.network_interface.0.nat_ip_address}
	ping -c 3 -W 2 ${yandex_compute_instance.k8s-worker1.network_interface.0.nat_ip_address}
	ping -c 3 -W 2 ${yandex_compute_instance.k8s-worker2.network_interface.0.nat_ip_address}
	ping -c 3 -W 2 ${yandex_compute_instance.k8s-worker3.network_interface.0.nat_ip_address}
	ping -c 3 -W 2 ${yandex_compute_instance.k8s-worker4.network_interface.0.nat_ip_address}
    EOT
  }

  depends_on = [
    null_resource.wait
  ]
}