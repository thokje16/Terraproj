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

module "db_install" {
  source              = "./modules/db-install"
  location            = var.location
  resource_group_name = var.resource_group_name
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
  nsg_id              = module.network.web_nsg_id
  storage_account_name = module.db_install.storage_account_name
  storage_account_key  = module.db_install.storage_account_key
  install_script_url  = "https://mariadbinstalltest.blob.core.windows.net/play/playbook.yml"
  depends_on          = [module.db_install, time_sleep.wait_for_rg]
}
output "debug_storage_account_name" {
  value = module.db_install.storage_account_name
}

output "installurl" {
  value = module.db_install.storage_account_name
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
  backend_pool_id     = module.loadbalancer.backend_pool_id
  storage_account_name = module.db_install.storage_account_name
  storage_account_key  = module.db_install.storage_account_key
  install_script_url   = "https://mariadbinstalltest.blob.core.windows.net/install/install_mariadb.sh"
  depends_on          = [module.db_install, time_sleep.wait_for_rg]
}

module "loadbalancer" {
  source              = "./modules/loadbalancer"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.db_subnet_id
  depends_on          = [time_sleep.wait_for_rg]
}
