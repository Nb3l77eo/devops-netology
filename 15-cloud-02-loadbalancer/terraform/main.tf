provider "yandex" {
  # Use "export YC_TOKEN=AAAAAAaaaaqqqqqq" to set OAuth token
  cloud_id  = "XXXXX"
  folder_id = "${var.YC_folder_id_value}"
  zone      = "${var.YC_zone}"
}
