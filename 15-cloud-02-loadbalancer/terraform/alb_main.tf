resource "yandex_alb_load_balancer" "alb-test-balancer" {
  name        = "alb-test-balancer"
  network_id  = yandex_vpc_network.net_default.id

  allocation_policy {
    location {
      zone_id   = var.YC_zone
      subnet_id = yandex_vpc_subnet.subnet_default.id
    }
  }

  listener {
    name = "alb-test-listner"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 9000 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb-http-router.id
      }
    }
  }
}