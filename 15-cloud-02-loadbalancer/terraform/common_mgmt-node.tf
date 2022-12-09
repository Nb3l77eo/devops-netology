resource "yandex_compute_instance" "mgmt-node" {
  name                      = "mgmt-node"
  zone                      = var.YC_zone
  hostname                  = "mgmt-node.netology.yc"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8hqa9gq1d59afqonsf" #https://cloud.yandex.ru/marketplace/products/yc/centos-7 
      name        = "mgmt-node"
      #type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet_default.id}"
    nat        = true
    ip_address = "192.168.101.5"
  }

  metadata = {
    user-data = "${file("meta/mgmt_node.data")}"
  }

  scheduling_policy {
    preemptible = true
  }
}