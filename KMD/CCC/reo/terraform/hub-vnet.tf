resource "azurerm_network_security_group" "hub_nsg" {
  name                = "${var.env}-${var.hub_vnet.vnet_name}-nsg"
  location            = var.common_location
  resource_group_name = azurerm_resource_group.reo-rg.name

  tags = var.tags
}

resource "azurerm_network_security_rule" "hub_nsg_rules" {
  name                        = "allow-port-${var.hub_vnet.allow_ports[count.index]}"
  priority                    = sum([100, count.index])
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = var.hub_vnet.allow_ports[count.index]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.reo-rg.name
  network_security_group_name = azurerm_network_security_group.hub_nsg.name

  count = length(var.hub_vnet.allow_ports)
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "${var.env}-${var.hub_vnet.vnet_name}"
  location            = var.common_location
  resource_group_name = azurerm_resource_group.reo-rg.name
  address_space       = var.hub_vnet.address_space
  dns_servers         = var.hub_vnet.dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "hub_subnets" {
  name             = local.hub_vnet.subnets[count.index].name
  address_prefixes = local.hub_vnet.subnets[count.index].address_prefixes

  count                = length(local.hub_vnet.subnets)
  resource_group_name  = azurerm_resource_group.reo-rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name

  dynamic "delegation" {
    for_each = local.hub_vnet.subnets[count.index].service_delegation == "true" ? [1] : []

    content {
      name = local.hub_vnet.service_delegation_details[local.hub_vnet.subnets[count.index].name].name

      service_delegation {
        name = local.hub_vnet.service_delegation_details[local.hub_vnet.subnets[count.index].name].sd_name
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "hub_nsg_association" {
  subnet_id                 = azurerm_subnet.hub_subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.hub_nsg.id

  count = length(local.hub_vnet.subnets)
}
