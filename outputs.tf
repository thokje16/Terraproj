output "web_vm_public_ip" {
  value = module.web_vm.public_ip_address
  description = "Offentlig IP for webserveren"
}

output "db_vm_ids" {
  value = [for db in module.db_vm : db.vm_id]
  description = "ID-er for database-VM-ene"
}

output "loadbalancer_id" {
  value = module.loadbalancer.lb_id
  description = "ID-en til lastbalansereren"
}
variable "install_script_url" {
  description = "URL to the MariaDB installation script"
  type        = string
}