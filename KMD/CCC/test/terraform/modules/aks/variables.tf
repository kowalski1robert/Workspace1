variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "node_pool_subnet_id" {
  type = string
}

variable "default_node_pool" {
  type = object({
    name       = string
    node_count = number
    vm_size    = string
  })
}

variable "identity_type" {
  type = string
}

variable "pod_subnet_id" {
  type = string
}

variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "tags" {
  type = map(any)
}
