resource "google_compute_network" "network" {
  name = "${terraform.workspace}-${var.network_name}"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${terraform.workspace}-${var.subnetwork_name}"
  network       = google_compute_network.network.self_link
  ip_cidr_range = var.subnetwork_range
}
