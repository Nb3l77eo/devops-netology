provider "yandex" {
  # Use "export YC_TOKEN=AAAAAAaaaaqqqqqq" to set OAuth token
  cloud_id  = var.YC_cloud_id
  folder_id = var.YC_folder_id
  zone      = var.YC_zone
}
