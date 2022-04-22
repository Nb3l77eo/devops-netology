#output "account_ID" {
#  value = "${yandex_iam_user.login}"
#}

#output "user_ID" {
#  value = "${yandex_iam_user.user_id}"
#}

output "Zone_node01_yandex_cloud" {
  value = "${yandex_compute_instance.node1.zone}"
}

output "internal_ip_address_node01_yandex_cloud" {
  value = "${yandex_compute_instance.node1.network_interface.0.ip_address}"
}

output "sudnet_id__node01_yandex_cloud" {
  value = "${yandex_compute_instance.node1.network_interface[*].subnet_id}"
}
