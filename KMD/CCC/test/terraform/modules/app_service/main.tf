resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.env}-${var.app_service_plan_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = var.sku_name
  os_type  = var.os_type

  tags = var.tags
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${var.env}-${var.app_service_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {}

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_vnet_connection" {
  app_service_id = azurerm_linux_web_app.app_service.id
  subnet_id      = var.subnet_id
}
