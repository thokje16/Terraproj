variable "location" {
  type        = string
  description = "Azure regionen"
  default     = "Norway East"
}


variable "admin_username" {
  type        = string
  description = "Admin-brukernavn for VM-ene"
  default     = "thorjo"
}

variable "admin_password" {
  type        = string
  description = "Admin-passord for VM-en"
  default     = "Passord123!"  # Bruk dette som standard for testtilfellet
}

variable "resource_group_name" {
  type        = string
  description = "Navnet på ressursgruppen i Azure"
}

# Nettverksinnstillinger
variable "vnet_name" {
  type        = string
  description = "Navnet på det virtuelle nettverket"
  default     = "myVNet"
}

variable "address_space" {
  type        = list(string)
  description = "Adresseområde for det virtuelle nettverket"
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_name" {
  type        = string
  description = "Navnet på subnettet for web-server"
  default     = "webSubnet"
}

variable "web_subnet_prefix" {
  type        = string
  description = "Adresseområde for subnettet for web-server"
  default     = "10.0.1.0/24"
}

variable "db_subnet_name" {
  type        = string
  description = "Navnet på subnettet for database-server"
  default     = "dbSubnet"
}

variable "db_subnet_prefix" {
  type        = string
  description = "Adresseområde for subnettet for database-server"
  default     = "10.0.2.0/24"
}

# VM-størrelser
variable "web_vm_size" {
  type        = string
  description = "Størrelsen på webserver-VM-en"
  default     = "Standard_DS1_v2"
}

variable "db_vm_size" {
  type        = string
  description = "Størrelsen på database-VM-ene"
  default     = "Standard_DS1_v2"
}
