resource "azurerm_resource_group" "reo-rg" {
  name     = "${var.env}-${var.resource_group_name}"
  location = var.common_location
}

module "vnet_hub" {
  source = "../modules/vnet"

  resource_group_name = azurerm_resource_group.reo-rg.name
  location            = var.common_location

  vnet_name     = var.hub_vnet.vnet_name
  address_space = var.hub_vnet.address_space
  dns_servers   = var.hub_vnet.dns_servers
  allow_ports   = var.hub_vnet.allow_ports
  subnets = {
    "${var.jumphost_subnet_name}" = {
      address_prefixes   = ["10.0.1.0/24"]
      service_delegation = false
    }
  }

  env  = var.env
  tags = var.tags
}

module "vnet_spoke" {
  source = "../modules/vnet"

  resource_group_name = azurerm_resource_group.reo-rg.name
  location            = var.common_location

  vnet_name     = var.spoke_vnet.vnet_name
  address_space = var.spoke_vnet.address_space
  dns_servers   = var.spoke_vnet.dns_servers
  allow_ports   = var.spoke_vnet.allow_ports
  subnets = {
    # "${var.node_pool_subnet_name}" = ["10.1.1.0/24"]
    # "${var.pod_subnet_name}"       = ["10.1.2.0/24"]
    "${var.app_service_subnet_name}" = {
      address_prefixes   = ["10.1.1.0/24"]
      service_delegation = "true"
    }
  }
  service_delegation_details = {
    "${var.app_service_subnet_name}" = {
      name    = "app_service_delegation"
      sd_name = "Microsoft.Web/serverFarms"
    }
  }

  env  = var.env
  tags = var.tags
}

module "peerings_vnet" {
  source = "../modules/peering-vnet"

  resource_group_name = azurerm_resource_group.reo-rg.name
  vnet1_name          = module.vnet_hub.vnet_name
  vnet2_name          = module.vnet_spoke.vnet_name
  vnet1_id            = module.vnet_hub.vnet_id
  vnet2_id            = module.vnet_spoke.vnet_id
}

module "jumphost" {
  source = "../modules/vm-jumphost"

  resource_group_name            = azurerm_resource_group.reo-rg.name
  location                       = var.common_location
  jumphost_name                  = var.jumphost_name
  jumphost_username              = var.jumphost_username
  jumphost_size                  = var.jumphost_size
  ip_configuration               = var.jumphost_ip_configuration
  os_disk                        = var.jumphost_os_disk_specs
  source_image_reference         = var.jumphost_source_image_reference
  jumphost_pip_name              = var.jumphost_pip_name
  jumphost_pip_allocation_method = var.jumphost_pip_allocation_method
  jumphost_nic_name              = var.jumphost_nic_name
  interface_subnet_id            = module.vnet_hub.subnet_ids[var.jumphost_subnet_name]

  env  = var.env
  tags = var.tags
}

module "app_service" {
  source = "../modules/app_service"

  location              = var.common_location
  app_service_plan_name = var.app_service_plan_name
  sku_name              = var.app_service_plan_sku_name
  os_type               = var.app_service_plan_os_type

  app_service_name    = var.app_service_name
  resource_group_name = azurerm_resource_group.reo-rg.name
  subnet_id           = module.vnet_spoke.subnet_ids[var.app_service_subnet_name]

  env  = var.env
  tags = var.tags
}

# module "aks" {
#   source = "../modules/aks"

#   resource_group_name = azurerm_resource_group.reo-rg.name
#   location            = var.common_location
#   cluster_name        = var.cluster_name
#   default_node_pool   = var.default_node_pool_specs
#   identity_type       = var.aks_identity_type

#   pod_subnet_id       = module.vnet_spoke.nsg_subnet_ids[var.pod_subnet_name]
#   node_pool_subnet_id = module.vnet_spoke.nsg_subnet_ids[var.node_pool_subnet_name]

#   env  = var.env
#   tags = var.tags
# }
