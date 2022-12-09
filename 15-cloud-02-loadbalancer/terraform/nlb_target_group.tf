resource "yandex_lb_target_group" "foo" {
  name      = "my-target-group"
  
  dynamic "target" {
    for_each = yandex_compute_instance_group.ig-my.instances.*.network_interface.0

    content {
      subnet_id = target.value["subnet_id"]
      address   = target.value["ip_address"]
    }
  }

  depends_on = [
    yandex_compute_instance_group.ig-my
  ]
}