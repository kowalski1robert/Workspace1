resource "azurerm_virtual_network_peering" "peer1to2" {
  name                      = "peer-${var.vnet1_name}-to-${var.vnet2_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id
}

resource "azurerm_virtual_network_peering" "peer2to1" {
  name                      = "peer-${var.vnet2_name}-to-${var.vnet1_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id
}
