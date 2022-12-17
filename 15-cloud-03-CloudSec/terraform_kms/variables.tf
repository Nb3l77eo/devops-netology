variable "YC_zone" {
  description = "List of control plane nodes"
  type = string
  default = "ru-central1-a"
}

variable "YC_folder_id_value" {
  description = "YC folder id value"
  type = string
  default = "b1g46m5trgidj8a4ll1d"
}

variable "YC_backet_name" {
  description = "YC backet name"
  type = string
  default = "nb3l77eo-06122022"
}


variable "YC_instance_group_size" {
  description = "Count nodes of fixed instance group"
  type = string
  default = 3
}

