resource "yandex_kubernetes_node_group" "k8s_ng-a" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name = "ng-a"
  instance_template {
    platform_id = "standard-v2"
    container_runtime {
      type = "containerd"
    }
    resources {
      memory = 4
      cores  = 2
      core_fraction = 20
    }
    boot_disk {
      type = "network-hdd"
      size = 30
    }
    network_interface {
      subnet_ids  = [yandex_vpc_subnet.mysubnet-a.id]
      nat        = true
    }
    metadata = {
      ssh-keys = "${var.username_def}:${file("~/.ssh/id_rsa.pub")}"
    }
    scheduling_policy {
      preemptible = true
    }
  }
  scale_policy {
    auto_scale {
      min     = 1
      max     = 3
      initial = 1
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }
}

resource "yandex_kubernetes_node_group" "k8s_ng-b" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name = "ng-b"
  instance_template {
    platform_id = "standard-v2"
    container_runtime {
      type = "containerd"
    }
    resources {
      memory = 4
      cores  = 2
      core_fraction = 20
    }
    boot_disk {
      type = "network-hdd"
      size = 30
    }
    network_interface {
      subnet_ids  = [yandex_vpc_subnet.mysubnet-b.id]
      nat        = true
    }
    metadata = {
      ssh-keys = "${var.username_def}:${file("~/.ssh/id_rsa.pub")}"
    }
    scheduling_policy {
      preemptible = true
    }
  }
  scale_policy {
    auto_scale {
      min     = 1
      max     = 3
      initial = 1
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }
}

resource "yandex_kubernetes_node_group" "k8s_ng-c" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name = "ng-c"
  instance_template {
    platform_id = "standard-v2"
    container_runtime {
      type = "containerd"
    }
    resources {
      memory = 4
      cores  = 2
      core_fraction = 20
    }
    boot_disk {
      type = "network-hdd"
      size = 30
    }
    network_interface {
      subnet_ids  = [yandex_vpc_subnet.mysubnet-c.id]
      nat        = true
    }
    metadata = {
      ssh-keys = "${var.username_def}:${file("~/.ssh/id_rsa.pub")}"
    }
    scheduling_policy {
      preemptible = true
    }
  }
  scale_policy {
    auto_scale {
      min     = 1
      max     = 3
      initial = 1
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-c"
    }
  }
}