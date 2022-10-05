# Azure GUIDS
variable "tenant_id" {
  type = string
  description = "Azure Tenant ID"
}
variable "client_id" {
  type = string
  description = "Azure Application ID"
}
variable "client_secret" {
  type = string
  sensitive = true
  description = "Azure Application Secret"
}
variable "subscription_id" {
  type = string
  description = "Azure Subscription ID"
}

# Resource Group/Location
variable "resource_group" {
  type = string
  description = "Resource Group Name"
  default = "rg-victor-vm-ws"
}
variable "location" {
  type = string
  description = "Resource Group Location"
  default = "westeurope"
}

# Network
variable "virtual_network_name" {
  type = string
  description = "Virtual Network Name"
  default = "smazurevmwsvn"
}
variable "address_space" {
  type = list(string)
  description = "Virtual Network Address Space"
  default = ["10.0.0.0/16"]
}
variable "address_prefixes" {
  type = list(string)
  description = "Virtual Network Address Space"
  default = ["10.0.1.0/24"]
}
# Virtual Machine
variable "vm_name" {
  type = string
  description = "Virtual Machine Name"
}
variable "vm_size" {
  type = map(string)
  description = "Virtual Machine Size"
    default = {
    dev = "Standard_B1ms"
    prd = "Standard_A2_v2"
  }
}
variable "vm_admin_username" {
  type = string
  description = "Virtual Machine Admin User"
  default = "adminmcc"
}
variable "sensitive_vm_admin_password" {
  type = string
  sensitive = true
  description = "Virtual Machine Admin Pwd"
}

# Virtual Machine Disk
variable "storage_account_type" {
  type = string
  description = "Storage Account Type"
  default = "Standard_LRS"
}
variable "disk_size_gb" {
  type = string
  description = "VM Disk Size"
  default = "70"
}

# Public IP
variable "public_ip_sku" {
  type = string
  description = "VM Public IP"
  default = "Basic"
}

variable "isproduction" {
  type = bool
  default = false
}
