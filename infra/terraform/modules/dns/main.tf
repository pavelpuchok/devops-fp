resource "google_dns_managed_zone" "dns_zone" {
  name     = var.dns_zone_name
  dns_name = var.dns_name
  count    = var.enabled ? 1 : 0
}

resource "google_dns_record_set" "frontend_dns_record_set" {
  name         = google_dns_managed_zone.dns_zone.0.dns_name
  type         = "A"
  ttl          = var.ttl
  managed_zone = google_dns_managed_zone.dns_zone.0.name
  rrdatas      = [var.address]
  count        = var.enabled ? 1 : 0
}

resource "google_dns_record_set" "frontend_dns_record_set_cname" {
  name         = "www.${google_dns_managed_zone.dns_zone.0.dns_name}"
  managed_zone = google_dns_managed_zone.dns_zone.0.name
  type         = "A"
  ttl          = var.ttl
  rrdatas      = [var.address]
  count        = var.enabled ? 1 : 0
}
