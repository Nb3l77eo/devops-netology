resource "yandex_compute_instance" "pubNodes" {
  count = "${length(var.public_nodes)}"
  name                      = "public-nodes-${element(var.public_nodes, count.index)}"
  zone                      = "${var.YC_zone}"
  hostname                  = "pub-${element(var.public_nodes, count.index)}.netology.yc"
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
      name        = "root-pub-${element(var.public_nodes, count.index)}"
      #type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet_public.id}"
    nat        = true
    ip_address = "192.168.10.${10+count.index}"
  }

  metadata = {
    user-data = "${file("common_meta.txt")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
