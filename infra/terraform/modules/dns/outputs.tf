output "name_servers" {
  value       = google_dns_managed_zone.dns_zone.0.name_servers
  description = "GCP Nameservers"
}
