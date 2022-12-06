variable "private_nodes" {
  description = "List of private_nodes"
  type = list
  default = [
    "pri1"
    ]
}

variable "public_nodes" {
  description = "List of public_nodes"
  type = list
  default = [
    "pub1"
    ]
}


variable "YC_zone" {
  description = "List of control plane nodes"
  type = string
  default = "ru-central1-a"
}