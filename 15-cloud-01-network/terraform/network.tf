# Network
resource "yandex_vpc_network" "net_default" {
  name = "net"
  # folder_id = "${yandex.folder_id}"
}

resource "yandex_vpc_subnet" "subnet_public" {
  name           = "public"
  zone           = "${var.YC_zone}"
  network_id     = "${yandex_vpc_network.net_default.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet_private" {
  name           = "private"
  zone           = "${var.YC_zone}"
  network_id     = "${yandex_vpc_network.net_default.id}"
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = "${yandex_vpc_route_table.rt.id}"
}


resource "yandex_vpc_route_table" "rt" {
  name        = "route-table"
  network_id  = "${yandex_vpc_network.net_default.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = "${yandex_compute_instance.nat-inst.network_interface.0.ip_address}"
  }
}