variable "vm_name" {
  type        = string
  description = "Navnet på VM-en"
}

variable "location" {
  type        = string
  description = "Azure-regionen"
}

variable "resource_group_name" {
  type        = string
  description = "Navnet på ressursgruppen"
}

variable "subnet_id" {
  type        = string
  description = "ID-en til subnettet VM-en skal være i"
}

variable "vm_size" {
  type        = string
  description = "Størrelsen på VM-en"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Brukernavn for VM-administratoren"
}

variable "admin_password" {
  type        = string
  description = "Brukernavn for VM-administratoren"
  default     = "Passord123!"
}
variable "assign_public_ip" {
  type        = bool
  description = "Angi om VM-en skal ha en offentlig IP-adresse"
  default     = false
}
variable "backend_pool_id" {
  type        = string
  description = "ID of the load balancer backend pool"
  default     = null
}
variable "nsg_id" {
  type        = string
  description = "ID of the network security group"
  default     = null
}
variable "storage_account_name" {
  type        = string
  description = "Name of the storage account for scripts"
  default     = "mariadbinstalltest"
}

variable "storage_account_key" {
  type        = string
  description = "Storage account key for script access"
  sensitive   = true

}
variable "install_script_url" {
  description = "URL to the MariaDB installation script"
  type        = string
  default     = "mariadbinstalltest"
}