provider "yandex" {
  # Use "export YC_TOKEN=AAAAAAaaaaqqqqqq" to set OAuth token
  cloud_id  = "b1gpe9o14ck01il0g1v0"
  folder_id = "b1g3nfj1m34nsm6diloa"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}


resource "yandex_compute_instance" "node1" {
  name                      = "firstnode"
  zone                      = "ru-central1-a"
  hostname                  = "firstnode.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8anitv6eua45627i0e" # https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts
      name        = "root-firstnode"
      type        = "network-nvme"
      size        = "30"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("meta.txt")}"  }
}
