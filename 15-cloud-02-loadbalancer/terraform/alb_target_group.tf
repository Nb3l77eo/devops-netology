resource "yandex_alb_target_group" "alb-tg-gr" {
  name           = "alb-tg-gr"


  dynamic "target" {
    for_each = yandex_compute_instance_group.ig-my.instances.*.network_interface.0

    content {
      subnet_id = target.value["subnet_id"]
      ip_address   = target.value["ip_address"]
    }
  }

  depends_on = [
    yandex_compute_instance_group.ig-my
  ]
}