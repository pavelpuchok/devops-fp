output "bastion_address" {
  value       = module.bastion.bastion_address
  description = "The public IP address of the bastion instance"
}

output "frontend_address" {
  value       = module.frontend.frontend_address
  description = "The public IP address of the frontend instance"
}

output "dns_name_servers" {
  value       = module.dns.name_servers
  description = "DNS nameservers"
}

output "swarm_internal_address" {
  value       = google_compute_instance.instance.network_interface.0.network_ip
  description = "The internal IP address of the swarm manager node"
}

