resource "yandex_lb_network_load_balancer" "lb_nlb" {
  name = "nlb-test"
  listener {
    name = "listner-nlb-http"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.foo.id
    healthcheck {
      name = "halthchek-nlb-http"
        http_options {
          port = 80
          path = "/index.html"
        }
    }
  }
}