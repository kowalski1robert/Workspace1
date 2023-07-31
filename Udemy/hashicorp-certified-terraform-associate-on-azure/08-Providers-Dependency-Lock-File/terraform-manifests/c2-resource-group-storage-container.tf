# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "my_rg" {
  name     = "rg-reo-terraform"
  location = "West Europe"
}

# Resource-2: Random String 
resource "random_string" "my_random_string" {
  length  = 16
  special = false
  upper   = false
}

# Resource-3: Azure Storage Account 
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "mysa${random_string.my_random_string.result}"
  resource_group_name      = azurerm_resource_group.my_rg.name
  location                 = azurerm_resource_group.my_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "test"
  }
}
