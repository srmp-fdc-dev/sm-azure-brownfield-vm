resource "azurerm_resource_group" "test" {
  name     = var.resource_group
  location = var.location

  tags = {
    Environment = var.isproduction == false ? "Development" : "Production"
  }
}