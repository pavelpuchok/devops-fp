resource "google_compute_network" "network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  network       = google_compute_network.network.self_link
  ip_cidr_range = var.subnetwork_range
}

resource "google_compute_address" "external_static" {
  name = var.external_address_name
}

resource "google_compute_firewall" "docker_firewall" {
  name    = "docker-firewall"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["2377"]
  }

  source_tags = ["docker"]
  target_tags = ["docker"]
}

resource "google_compute_firewall" "ssh_firewall" {
  name    = "ssh-firewall"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
