variable "YC_zone" {
  description = "List of control plane nodes"
  type = string
  default = "ru-central1-a"
}

variable "YC_cloud_id" {
  description = "YC cloud id value"
  type = string
}

variable "YC_folder_id" {
  description = "YC folder id value"
  type = string
}

variable "YC_instance_group_size" {
  description = "Count nodes of fixed instance group"
  type = string
  default = 3
}

variable "k8s_version" {
  description = "Kubernetes version"
  type = string
  default = 1.22
}

variable "username_def" {
  description = "default user name"
  type = string
  default = "vagrant"
}