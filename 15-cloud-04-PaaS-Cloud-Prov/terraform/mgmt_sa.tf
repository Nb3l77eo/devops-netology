resource "yandex_iam_service_account" "mgmt-sa" {
  name        = "mgmt-sa"
  description = "k8s admin SA"
}

resource "yandex_resourcemanager_folder_iam_binding" "mgmt-sa-editor" {
  # Сервисному аккаунту назначается роль "editor".
  folder_id = var.YC_folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.mgmt-sa.id}"
  ]
}