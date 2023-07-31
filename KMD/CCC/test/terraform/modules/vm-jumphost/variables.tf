variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "interface_subnet_id" {
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

variable "jumphost_pip_name" {
  type = string
}

variable "jumphost_pip_allocation_method" {
  type = string
}

variable "jumphost_size" {
  type = string
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "ip_configuration" {
  type = object({
    name                          = string
    private_ip_address_allocation = string
  })
}
