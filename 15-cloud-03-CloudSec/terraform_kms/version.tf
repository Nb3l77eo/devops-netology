terraform {
  required_providers {
    yandex = {
      # source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
