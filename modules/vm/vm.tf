resource "azurerm_network_interface" "test" {
  name                = "${var.vm_name}-${var.resource_type}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }

  tags = {
    Environment = var.isproduction ? "Development" : "Production"
  }
}

resource "azurerm_virtual_machine" "dev" {
  count = var.isproduction ? 0 : 1

  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group
  vm_size             = var.vm_size["dev"]
  network_interface_ids = [azurerm_network_interface.test.id]
  
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Core"
    version   = "latest"
  }
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = {
    Environment = "Development"
  }
}

resource "azurerm_virtual_machine" "prd" {
  count = var.isproduction ? 1 : 0

  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group
  vm_size             = var.vm_size["prd"]
  network_interface_ids = [azurerm_network_interface.test.id]
  
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Core"
    version   = "latest"
  }
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
  tags = {
    Environment = "Production"
  }
}