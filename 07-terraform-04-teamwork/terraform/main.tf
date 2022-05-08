provider "yandex" {
  # Use "export YC_TOKEN=AAAAAAaaaaqqqqqq" to set OAuth token
  cloud_id  = "b1gpe9o14ck01il0g1v0"
  folder_id = "b1g3nfj1m34nsm6diloa"
  zone      = "ru-central1-a"
}


resource "yandex_compute_instance" "node1" {
  name                      = "node-${count.index}"
  zone                      = "ru-central1-a"
  hostname                  = "node1${count.index}.netology.cloud"
  allow_stopping_for_update = true
  platform_id = local.node1_conf_instance_platfrom[terraform.workspace]
  count = local.node1_instance_count[terraform.workspace]

  resources {
   cores = local.node1_conf_instance_cores[terraform.workspace]
   memory = local.node1_conf_instance_memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8anitv6eua45627i0e" # https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts
      name        = "root-node1${count.index}"
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


resource "yandex_compute_instance" "node2" {
 for_each = local.feach_env

 resources {
   cores  = each.value.cores
   memory = each.value.memory
 }

 boot_disk {
   initialize_params {
     image_id    = "fd8anitv6eua45627i0e" # https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts
     name        = "root-node1${each.value.name}"
     type        = "network-nvme"
     size        = "30"
   }
 }

 network_interface {
   subnet_id = "${yandex_vpc_subnet.default.id}"
   nat       = true
 }
 metadata = {
 user-data = "${file("meta.txt")}"
 }
}
