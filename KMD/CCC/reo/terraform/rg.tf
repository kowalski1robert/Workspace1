resource "azurerm_resource_group" "reo-rg" {
  name     = "${var.env}-${var.resource_group_name}"
  location = var.common_location
}
