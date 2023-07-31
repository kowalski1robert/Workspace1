resource "azurerm_virtual_network_peering" "peer1to2" {
  name                      = "peer-${azurerm_virtual_network.hub_vnet.name}-to-${azurerm_virtual_network.spoke_vnet.name}"
  resource_group_name       = azurerm_resource_group.reo-rg.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
}

resource "azurerm_virtual_network_peering" "peer2to1" {
  name                      = "peer-${azurerm_virtual_network.spoke_vnet.name}-to-${azurerm_virtual_network.hub_vnet.name}"
  resource_group_name       = azurerm_resource_group.reo-rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
}
