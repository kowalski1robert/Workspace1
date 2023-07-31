# Resource Block
# Create a resource group
resource "azurerm_resource_group" "myrg" {
  name     = "rg-reo-terraform"
  location = "westeurope"
}
