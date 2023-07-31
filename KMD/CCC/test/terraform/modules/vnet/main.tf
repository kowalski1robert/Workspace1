resource "azurerm_network_security_group" "nsg" {
  name                = "${var.env}-${var.vnet_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "nsg_rules" {
  name                        = "allow-port-${var.allow_ports[count.index]}"
  priority                    = sum([100, count.index])
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = var.allow_ports[count.index]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name

  count = length(var.allow_ports)
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.env}-${var.vnet_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "subnets" {
  name             = each.key
  address_prefixes = each.value.address_prefixes

  for_each             = var.subnets
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  dynamic "delegation" {
    for_each = each.value.service_delegation == "true" ? [1] : []

    content {
      name = var.service_delegation_details[each.key].name

      service_delegation {
        name = var.service_delegation_details[each.key].sd_name
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg.id

  for_each = var.subnets
}
