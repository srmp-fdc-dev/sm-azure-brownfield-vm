resource "azurerm_network_security_group" "nsg" {
  name                = "${var.vm_name}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
        name                       = "RDP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
  tags = {
    Environment = var.isproduction == false ? "Development" : "Production"
  }
}
resource "azurerm_subnet_network_security_group_association" "test" {
    subnet_id                 = var.subnet_id
    network_security_group_id = azurerm_network_security_group.nsg.id
}
