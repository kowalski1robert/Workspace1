# Basics
variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type = map(any)
}

# app service plan vars
variable "app_service_plan_name" {
  type = string
}

variable "os_type" {
  type = string
}

variable "sku_name" {
  type = string
}

# app service vars
variable "app_service_name" {
  type = string
}

variable "subnet_id" {
  type = string
}
