terraform {
  backend "remote" {
    # Leave this empty
    # Partially configured backend
    # Will be used for validation via CI/CD
  }
}

provider "azurerm" {
features {}
# More information on the authentication methods supported by
# the AzureRM Provider can be found here:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
tenant_id = var.tenant_id
client_id = var.client_id
client_secret = var.client_secret
subscription_id = var.subscription_id
}

module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = var.resource_group
  location             = var.location
  isproduction         = var.isproduction
}

module "network" {
  source                = "./modules/network"
  address_space         = var.address_space
  location              = var.location
  virtual_network_name  = var.virtual_network_name
  vm_name               = var.vm_name
  resource_type         = "NET"
  resource_group        = module.resource_group.resource_group_name
  address_prefixes      = var.address_prefixes
  isproduction         = var.isproduction
}

module "nsg-test" {
  source                = "./modules/networksecuritygroup"
  location              = var.location
  vm_name               = var.vm_name
  resource_type         = "NSG"
  resource_group        = module.resource_group.resource_group_name
  subnet_id             = module.network.subnet_id_test
  address_prefixes      = var.address_prefixes
  isproduction         = var.isproduction
}

module "publicip" {
  source           = "./modules/publicip"
  location         = var.location
  vm_name          = var.vm_name
  resource_type    = "publicip"
  resource_group   = module.resource_group.resource_group_name
  public_ip_sku    = var.public_ip_sku
  isproduction         = var.isproduction
}

module "vm" {
  source               = "./modules/vm"
  location             = var.location
  resource_group       = module.resource_group.resource_group_name
  vm_name              = var.vm_name
  vm_size              = var.vm_size
  resource_type        = "vm"
  subnet_id            = module.network.subnet_id_test
  public_ip_address_id = module.publicip.public_ip_address_id
  vm_admin_username    = var.vm_admin_username
  vm_admin_password    = var.vm_admin_password
  storage_account_type = var.storage_account_type
  disk_size_gb         = var.disk_size_gb
  isproduction         = var.isproduction
}


