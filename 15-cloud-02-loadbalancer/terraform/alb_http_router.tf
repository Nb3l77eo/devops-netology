resource "yandex_alb_http_router" "alb-http-router" {
  name   = "alb-http-router"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "my-virtual-host" {
  name           = "vhost-name"
  http_router_id = yandex_alb_http_router.alb-http-router.id
  route {
    name = "alb-vhost"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb-backend-group.id
        timeout          = "3s"
      }
    }
  }
} 