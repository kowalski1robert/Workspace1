remote_state {
    // backend = "azurerm"
    // config = {
    //     key = "${path_relative_to_include()}/terraform.tfstate"
    //     resource_group_name = "RemoveTerraform"
    //     storage_account_name = "tsushistatetf"
    //     container_name = "tfstate"
    // }
  backend = "azurerm" 
  config = {
    resource_group_name  = "rg-reo-tf-backend"
    storage_account_name = "sareotfbackend"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
    // use_azuread_auth     = true
    // subscription_id      = "f72dbffd-c9e9-4bfd-9727-a72b1acc2b00"
    // tenant_id            = "1aaaea9d-df3e-4ce7-a55d-43de56e79442"
    access_key = "2YN7mkY7AVvfwcmII339VxuU6hbMh4IZI/H378PJtroygbEX2vSdObMzy9MNQW8as56ZQAGU36d7+AStHtNUrQ=="
  }
}


inputs = {
    location = "westus"
    resource_group_name = "rg-reo-terragrunt"
}