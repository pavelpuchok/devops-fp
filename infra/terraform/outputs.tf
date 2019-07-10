output "external_address" {
  value       = google_compute_address.external_static.address
  description = "The public IP address of the main swarm instance"
}
