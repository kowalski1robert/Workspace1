resource "azurerm_key_vault" "kv" {
  name                      = local.kv_name
  resource_group_name       = local.rg_name
  location                  = local.location
  enable_rbac_authorization = true
  sku_name                  = "standard"
  tenant_id                 = data.azurerm_subscription.current.tenant_id

  tags = local.common_tags
}
