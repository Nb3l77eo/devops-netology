
resource "yandex_iam_service_account" "myaccount" {
  name        = local.sa_name
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "admin" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.YC_folder_id
  role      = "admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "aim-admin" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.YC_folder_id
  role      = "iam.admin"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}


resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.YC_folder_id
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}




resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.YC_folder_id
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.YC_folder_id
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}",
  ]
}
