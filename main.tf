module "network" {
  source              = "./modules/network"
  vnet_name           = "myVNet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  web_subnet_name     = "webSubnet"
  web_subnet_prefix   = "10.0.1.0/24"
  db_subnet_name      = "dbSubnet"
  db_subnet_prefix    = "10.0.2.0/24"
  depends_on          = [time_sleep.wait_for_rg]
}

module "web_vm" {
  source              = "./modules/vm"
  vm_name             = "web-server"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.web_subnet_id
  vm_size             = var.web_vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  assign_public_ip    = true  # Kun web_vm får offentlig IP
  depends_on          = [time_sleep.wait_for_rg]
}

module "db_vm" {
  source              = "./modules/vm"
  count               = 2  # To database-VM-er
  vm_name             = "db-server-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.db_subnet_id
  vm_size             = var.db_vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  assign_public_ip    = false # Ingen offentlig IP for db_vm
  depends_on          = [time_sleep.wait_for_rg]
}

module "loadbalancer" {
  source              = "./modules/loadbalancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.db_subnet_id
  depends_on          = [time_sleep.wait_for_rg]
}
