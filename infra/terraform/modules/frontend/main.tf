resource "google_compute_address" "external_static" {
  name  = var.address_name
  count = var.enabled ? 1 : 0
}

resource "google_compute_instance" "frontend" {
  name         = var.instance_name
  zone         = var.zone
  machine_type = var.machine_type
  tags         = [var.tag]
  count        = var.enabled ? 1 : 0

  network_interface {
    subnetwork = var.subnetwork

    access_config {
      nat_ip = google_compute_address.external_static.0.address
    }
  }

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }
}

resource "google_compute_firewall" "frontend_http_firewall" {
  name    = var.http_firewall_name
  network = var.network
  count   = var.enabled ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = ["53", "80", "443"]
  }

  source_ranges = var.source_ranges
  target_tags   = [var.tag]
}
