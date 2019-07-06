output "main_runner_ip" {
  value       = google_compute_address.main_runner_external_static.address
  description = "The public IP address of the main runner instance"
}
