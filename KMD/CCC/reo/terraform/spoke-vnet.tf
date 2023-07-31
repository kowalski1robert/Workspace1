resource "azurerm_network_security_group" "spoke_nsg" {
  name                = "${var.env}-${var.spoke_vnet.vnet_name}-nsg"
  location            = var.common_location
  resource_group_name = azurerm_resource_group.reo-rg.name

  tags = var.tags
}

resource "azurerm_network_security_rule" "spoke_nsg_rules" {
  name                        = "allow-port-${var.spoke_vnet.allow_ports[count.index]}"
  priority                    = sum([100, count.index])
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = var.spoke_vnet.allow_ports[count.index]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.reo-rg.name
  network_security_group_name = azurerm_network_security_group.spoke_nsg.name

  count = length(var.spoke_vnet.allow_ports)
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "${var.env}-${var.spoke_vnet.vnet_name}"
  location            = var.common_location
  resource_group_name = azurerm_resource_group.reo-rg.name
  address_space       = var.spoke_vnet.address_space
  dns_servers         = var.spoke_vnet.dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "spoke_subnets" {
  name             = local.spoke_vnet.subnets[count.index].name
  address_prefixes = local.spoke_vnet.subnets[count.index].address_prefixes

  count                = length(local.spoke_vnet.subnets)
  resource_group_name  = azurerm_resource_group.reo-rg.name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name

  dynamic "delegation" {
    for_each = local.spoke_vnet.subnets[count.index].service_delegation == "true" ? [1] : []

    content {
      name = local.spoke_vnet.service_delegation_details[local.spoke_vnet.subnets[count.index].name].name

      service_delegation {
        name = local.spoke_vnet.service_delegation_details[local.spoke_vnet.subnets[count.index].name].sd_name
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "spoke_nsg_association" {
  subnet_id                 = azurerm_subnet.spoke_subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.spoke_nsg.id

  count = length(local.spoke_vnet.subnets)
}
