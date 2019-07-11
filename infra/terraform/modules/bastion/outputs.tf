output "bastion_address" {
  value       = google_compute_instance.bastion_instance.0.network_interface.0.access_config.0.nat_ip
  description = "GCP Nameservers"
}
