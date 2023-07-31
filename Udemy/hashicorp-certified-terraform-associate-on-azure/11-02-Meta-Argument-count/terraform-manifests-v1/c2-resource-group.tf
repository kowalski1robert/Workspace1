# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "my-rg" {
  name     = "my-rg-${count.index}"
  location = "West Europe"
  count    = 3
}
