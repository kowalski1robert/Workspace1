resource "random_string" "random_suffix" {
  length  = 16
  special = false
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.env}-${var.app_service_plan_name}"
  location            = var.common_location
  resource_group_name = azurerm_resource_group.reo-rg.name

  sku_name = var.app_service_plan_sku_name
  os_type  = var.app_service_plan_os_type

  tags = var.tags
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${var.env}-${var.app_service_name}-${random_string.random_suffix.result}"
  location            = var.common_location
  resource_group_name = azurerm_resource_group.reo-rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {}

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_vnet_connection" {
  app_service_id = azurerm_linux_web_app.app_service.id
  subnet_id      = azurerm_subnet.spoke_subnets[0].id
}
