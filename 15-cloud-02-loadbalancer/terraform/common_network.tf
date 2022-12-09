# Network
resource "yandex_vpc_network" "net_default" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet_default" {
  name           = "subnet_default_name"
  zone           = "${var.YC_zone}"
  network_id     = "${yandex_vpc_network.net_default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_route_table" "rt" {
  name        = "test-route-table"
  network_id  = "${yandex_vpc_network.net_default.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = "${yandex_vpc_gateway.nat_gateway.id}"
  }
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}
