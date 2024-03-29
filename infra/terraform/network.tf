resource "google_compute_network" "network" {
  name = "${terraform.workspace}-${var.network_name}"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${terraform.workspace}-${var.subnetwork_name}"
  network       = google_compute_network.network.self_link
  ip_cidr_range = var.subnetwork_range
}

resource "google_compute_firewall" "internal_firewall" {
  name    = "${terraform.workspace}-internal-firewall"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["frontend"]
  target_tags = formatlist("${terraform.workspace}-%s", var.tags_manager)
}
