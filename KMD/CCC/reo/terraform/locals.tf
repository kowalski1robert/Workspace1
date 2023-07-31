locals {
  spoke_vnet = {
    subnets = [
      {
        name               = var.app_service_subnet_name
        address_prefixes   = ["10.1.1.0/24"]
        service_delegation = "true"
      }
    ]
    service_delegation_details = {
      "${var.app_service_subnet_name}" = {
        name    = "app_service_delegation"
        sd_name = "Microsoft.Web/serverFarms"
      }
    }
  }

  hub_vnet = {
    subnets = [
      {
        name               = var.jumphost_subnet_name
        address_prefixes   = ["10.0.1.0/24"]
        service_delegation = false
      }
    ]
  }
}
