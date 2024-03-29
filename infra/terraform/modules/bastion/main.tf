resource "google_compute_instance" "bastion_instance" {
  name         = var.instance_name
  zone         = var.zone
  machine_type = var.machine_type
  tags         = [var.tag]
  count        = var.enabled ? 1 : 0

  network_interface {
    subnetwork = var.subnetwork

    access_config {
    }
  }

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }
}

resource "google_compute_firewall" "bastion_ssh_firewall" {
  name    = "${var.ssh_firewall_name}"
  network = var.network
  count   = var.enabled ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = [var.ssh_port]
  }

  source_ranges = var.source_ranges
  target_tags   = [var.tag]
}

resource "google_compute_firewall" "bastion_ssh_firewall_internal" {
  name    = "${var.ssh_firewall_name}-internal"
  network = var.network
  count   = var.enabled ? 1 : 0

  allow {
    protocol = "tcp"
    ports    = [var.ssh_port]
  }

  source_tags = [var.tag]
}
