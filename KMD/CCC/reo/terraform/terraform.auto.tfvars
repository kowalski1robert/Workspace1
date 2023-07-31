# Basics
resource_group_name = "rg-reo-atlantis-project"
common_location     = "West Europe"
env                 = "dev"
tags = {
  created_by = "foo"
}

# hub_vnet vars
hub_vnet = {
  vnet_name     = "vnet_hub"
  address_space = ["10.0.0.0/16"]
  dns_servers   = ["10.0.0.4", "10.0.0.5"]
  subnets       = {}
  allow_ports   = ["22"]
}

# spoke_vnet vars
spoke_vnet = {
  vnet_name     = "vnet_spoke"
  address_space = ["10.1.0.0/16"]
  dns_servers   = ["10.1.0.4", "10.1.0.5"]
  subnets       = {}
  allow_ports   = []
}
# jumphost module vars
jumphost_subnet_name = "jumphost_subnet"
jumphost_username    = "jumphostAdmin"
jumphost_name        = "jumphost-vm"
jumphost_size        = "Standard_B2s"
jumphost_os_disk = {
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
}
jumphost_source_image_reference = {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts-gen2"
  version   = "latest"
}
jumphost_ip_configuration = {
  name                          = "internal"
  private_ip_address_allocation = "Dynamic"
}
jumphost_pip_name              = "jumphost_pip"
jumphost_pip_allocation_method = "Static"
jumphost_nic_name              = "jumphost-nic"

# app service module vars
app_service_plan_name     = "app-service-plan"
app_service_plan_sku_name = "B1"
app_service_plan_os_type  = "Linux"
app_service_name          = "app-service"
app_service_subnet_name   = "app-services-subnet"
