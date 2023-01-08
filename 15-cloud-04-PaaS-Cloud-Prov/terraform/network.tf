
resource "yandex_vpc_network" "mynet" {
  name = "mynet"
}

resource "yandex_vpc_subnet" "mysubnet-a" {
  v4_cidr_blocks = ["10.5.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.mynet.id
}

resource "yandex_vpc_subnet" "mysubnet-b" {
  v4_cidr_blocks = ["10.6.0.0/16"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.mynet.id
}

resource "yandex_vpc_subnet" "mysubnet-c" {
  v4_cidr_blocks = ["10.7.0.0/16"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.mynet.id
}
