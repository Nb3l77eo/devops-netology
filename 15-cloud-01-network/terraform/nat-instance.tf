resource "yandex_compute_instance" "nat-inst" {
  name                      = "nat-inst"
  zone                      = "${var.YC_zone}"
  hostname                  = "nat-inst.netology.yc"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  
  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8o8aph4t4pdisf1fio" #https://cloud.yandex.ru/marketplace/products/yc/nat-instance-ubuntu-18-04-lts
      name        = "root-nat"
      #type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet_public.id}"
    nat        = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    user-data = "${file("common_meta.txt")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
