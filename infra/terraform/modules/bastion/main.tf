resource "google_compute_instance" "bastion_instance" {
  name         = var.instance_name
  zone         = var.zone
  machine_type = var.machine_type
  tags         = [ var.tag ]

  network_interface {
    subnetwork = var.subnetwork

    access_config {
      nat_ip = google_compute_address.bastion_external_static.address
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

resource "google_compute_address" "bastion_external_static" {
  name = var.external_address_name
}

resource "google_compute_firewall" "bastion_ssh_firewall" {
  name    = var.ssh_firewall_name
  network = var.network

  allow {
    protocol = "tcp"
    ports    = [var.ssh_port]
  }

  source_ranges = var.source_ranges
  target_tags   = [ var.tag ]
}

resource "google_compute_firewall" "bastion_ssh_firewall" {
  name    = var.ssh_firewall_name
  network = var.network

  allow {
    protocol = "tcp"
    ports    = [var.ssh_port]
  }

  source_tags     = [ var.tag ]
  target_ragnes   = var.internal_target_ranges
}
