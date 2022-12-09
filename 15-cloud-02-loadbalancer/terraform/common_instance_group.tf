resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "service account to manage IG"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.YC_folder_id_value
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
  ]
  depends_on = [
    yandex_iam_service_account.ig-sa,
  ]
}

resource "yandex_compute_instance_group" "ig-my" {
  name               = "test-fixed-ig"
  folder_id          = var.YC_folder_id_value
  service_account_id = "${yandex_iam_service_account.ig-sa.id}"
  depends_on          = [yandex_resourcemanager_folder_iam_binding.editor, null_resource.prepare_meta]
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.net_default.id
      subnet_ids = [yandex_vpc_subnet.subnet_default.id]
    }

    metadata = {
      user-data = "${file("meta/common.data")}"
    }

    scheduling_policy {
        preemptible = true
    }
  }

  scale_policy {
    fixed_scale {
      size = var.YC_instance_group_size
    }
  }

  allocation_policy {
    zones = [var.YC_zone]
  }

  deploy_policy {
    max_unavailable = 0
    max_expansion = 1
  }
}
