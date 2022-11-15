resource "yandex_compute_instance" "k8s-master1" {
  name                      = "k8s-master1"
  zone                      = "ru-central1-a"
  hostname                  = "k8s-master1.netology.yc"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
    core_fraction = 50
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8hqa9gq1d59afqonsf" #https://cloud.yandex.ru/marketplace/products/yc/centos-7
      name        = "root-k8s-master1"
      #type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.default.id}"
    nat        = true
    # ip_address = "192.168.101.11"
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
