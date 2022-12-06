provider "yandex" {
  # Use "export YC_TOKEN=AAAAAAaaaaqqqqqq" to set OAuth token
  cloud_id  = "b1geb139r52nt0tj6377"
  folder_id = "b1g46m5trgidj8a4ll1d"
  zone      = "${var.YC_zone}"
}
