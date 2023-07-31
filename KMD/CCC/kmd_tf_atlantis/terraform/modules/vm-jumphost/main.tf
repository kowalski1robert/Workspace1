resource "tls_private_key" "jumphost-ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_network_interface" "jumphost-nic" {
  name                = "${var.env}-${var.jumphost_nic_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration.name
    subnet_id                     = var.interface_subnet_id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.jumphost_pip.id
  }

  tags = var.tags
}

resource "azurerm_public_ip" "jumphost_pip" {
  name                = var.jumphost_pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.jumphost_pip_allocation_method

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "jumphost-vm" {
  name                = "${var.env}-${var.jumphost_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.jumphost_size
  admin_username      = var.jumphost_username
  network_interface_ids = [
    azurerm_network_interface.jumphost-nic.id,
  ]

  admin_ssh_key {
    username   = var.jumphost_username
    public_key = tls_private_key.jumphost-ssh-key.public_key_openssh
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  tags = var.tags
}
