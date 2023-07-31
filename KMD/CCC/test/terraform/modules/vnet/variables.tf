variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "dns_servers" {
  type = list(string)
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes   = list(string)
    service_delegation = string
  }))
}

variable "allow_ports" {
  type = list(string)
}

variable "service_delegation_details" {
  type = map(object({
    name    = string
    sd_name = string
  }))
  default = {}
}
