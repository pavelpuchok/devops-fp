resource "google_dns_managed_zone" "dns_zone" {
  name = var.dns_zone_name
  dns_name = var.dns_name
  count = var.count
}

resource "google_dns_record_set" "frontend_dns_record_set" {
  name = "record_set.A.${google_dns_managed_zone.dns_zone.dns_name}"
  type = "A"
  ttl  = var.ttl
  managed_zone = google_dns_managed_zone.dns_zone.name
  rrdatas = [var.address]
  count = var.count
}

resource "google_dns_record_set" "frontend_dns_record_set_cname" {
  name = "record_set.cname.${google_dns_managed_zone.dns_zone.dns_name}"
  managed_zone = google_dns_managed_zone.dns_zone.name
  type = "CNAME"
  ttl  = var.ttl
  rrdatas = ["${google_dns_managed_zone.dns_zone.dns_name}."]
  count = var.count
}