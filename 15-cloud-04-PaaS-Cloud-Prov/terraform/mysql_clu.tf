
resource "yandex_mdb_mysql_cluster" "first_mysql_clu" {
  name                = "test-mysql-cluster"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.mynet.id
  version             = "8.0"
  deletion_protection = false #true

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = "20"
  }

  host {
    name = "na-1"
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.mysubnet-a.id
  }

  host {
    name = "nb-1"
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.mysubnet-b.id
  }

  timeouts {
    create = "1h30m" # Полтора часа
    update = "2h"    # 2 часа
    delete = "30m"   # 30 минут
  }

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  maintenance_window {
    type = "ANYTIME"
  }
}

resource "yandex_mdb_mysql_database" "db_test" {
  cluster_id = yandex_mdb_mysql_cluster.first_mysql_clu.id
  name       = "netology_db"

  depends_on = [
    yandex_mdb_mysql_cluster.first_mysql_clu
  ]
}

resource "yandex_mdb_mysql_user" "u_vagrant" {
  cluster_id = yandex_mdb_mysql_cluster.first_mysql_clu.id
  name       = "vagrant"
  password   = "vagrant123456"
  permission {
    database_name = "netology_db"
    roles         = ["ALL"]
  }

  depends_on = [
    yandex_mdb_mysql_database.db_test
  ]
}
