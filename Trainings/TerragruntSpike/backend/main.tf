provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg_tf_backend" {
  name     = "rg-reo-tf-backend"
  location = "West Europe"
  tags     = var.tags
}

resource "azurerm_storage_account" "sa_tf_backend" {
  name                     = "satfbackend${random_string.sa_name_generator.result}"
  resource_group_name      = azurerm_resource_group.rg_tf_backend.name
  location                 = azurerm_resource_group.rg_tf_backend.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc_tf_backend" {
  name                  = "tfbackend"
  storage_account_name  = azurerm_storage_account.sa_tf_backend.name
  container_access_type = "private"
}

resource "random_string" "sa_name_generator" {
  length  = 16
  special = false
  upper   = false
}
