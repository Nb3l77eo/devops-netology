resource "yandex_alb_backend_group" "alb-backend-group" {
  name                     = "alb-backeng-gr-1"
  session_affinity {
    connection {
      source_ip = false
    }
  }

  http_backend {
    name                   = "alb-backend-1"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.alb-tg-gr.id]
    load_balancing_config {
      panic_threshold      = 90
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15 
      http_healthcheck {
        path               = "/"
      }
    }
  }
}