resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.env}-${var.cluster_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.env}-${var.cluster_name}"

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    vm_size    = var.default_node_pool.vm_size
    # pod_subnet_id = var.pod_subnet_id
    # vnet_subnet_id      = var.node_pool_subnet_id
    enable_auto_scaling = false
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags
}
