resource "yandex_kms_symmetric_key" "key-a" {
  name              = "test-key"
  description       = "4backet"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 год
}
