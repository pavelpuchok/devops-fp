output "frontend_address" {
  value       = google_compute_instance.frontend.0.network_interface.0.access_config.0.nat_ip
  description = "Frontend instance external IP address"
}
