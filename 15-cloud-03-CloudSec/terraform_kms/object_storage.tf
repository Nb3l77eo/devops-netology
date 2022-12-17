resource "yandex_iam_service_account" "sa" {
  name = "obj-stor-15-2"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.YC_folder_id_value
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on = [
    yandex_iam_service_account.sa
  ]
}

resource "yandex_resourcemanager_folder_iam_member" "sa-kmskeys" {
  folder_id = var.YC_folder_id_value
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  depends_on = [
    yandex_iam_service_account.sa
  ]
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
  depends_on = [
    yandex_resourcemanager_folder_iam_member.sa-editor
  ]
}

// Создание публичного бакета с использованием ключа
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.YC_backet_name
  anonymous_access_flags {
    read = true
    list = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  depends_on = [
    yandex_iam_service_account_static_access_key.sa-static-key
  ]
}

// Загрузка объекта
resource "yandex_storage_object" "test-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.YC_backet_name
  key        = "f51406d4fe8d583540307964caacb7b5.jpg"
  source     = "files/f51406d4fe8d583540307964caacb7b5.jpg"

  depends_on = [
    yandex_storage_bucket.test
  ]
}