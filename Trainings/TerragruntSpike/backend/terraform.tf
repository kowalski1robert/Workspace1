terraform {
  backend "azurerm" {
    resource_group_name  = "rg-reo-tf-backend"
    storage_account_name = "sareotfbackend"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
    use_msi              = true
    subscription_id      = "f72dbffd-c9e9-4bfd-9727-a72b1acc2b00"
    tenant_id            = "1aaaea9d-df3e-4ce7-a55d-43de56e79442"
  }
}
