# Basics
variable "resource_group_name" {
  type = string
}

variable "common_location" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type = map(any)
}

# hub_vnet vars
variable "hub_vnet" {
  type = object({
    vnet_name     = string
    address_space = list(string)
    dns_servers   = list(string)
    allow_ports   = list(string)
  })
}

variable "spoke_vnet" {
  type = object({
    vnet_name     = string
    address_space = list(string)
    dns_servers   = list(string)
    allow_ports   = list(string)
  })
}

# jumphost vars
variable "jumphost_subnet_name" {
  type = string
}

variable "jumphost_username" {
  type = string
}

variable "jumphost_name" {
  type = string
}

variable "jumphost_nic_name" {
  type = string
}

variable "jumphost_size" {
  type = string
}

variable "jumphost_os_disk_specs" {
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "jumphost_ip_configuration" {
  type = object({
    name                          = string
    private_ip_address_allocation = string
  })
}

variable "jumphost_source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "jumphost_pip_name" {
  type = string
}

variable "jumphost_pip_allocation_method" {
  type = string
}

# app service plan vars
variable "app_service_plan_name" {
  type = string
}

variable "app_service_plan_sku_name" {
  type = string
}

variable "app_service_plan_os_type" {
  type = string
}

# app service vars
variable "app_service_name" {
  type = string
}

variable "app_service_subnet_name" {
  type = string
}

# aks vars
variable "cluster_name" {
  type = string
}

variable "aks_identity_type" {
  type = string
}

variable "default_node_pool_specs" {
  type = object({
    name       = string
    node_count = number
    vm_size    = string
  })
}

variable "node_pool_subnet_name" {
  type = string
}

variable "pod_subnet_name" {
  type = string
}
