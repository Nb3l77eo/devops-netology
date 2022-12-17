provider "yandex" {
  # Use "export YC_TOKEN=AAAAAAaaaaqqqqqq" to set OAuth token
  cloud_id  = "b1geb139r52nt0tj6377"
  folder_id = "${var.YC_folder_id_value}"
  zone      = "${var.YC_zone}"
}
