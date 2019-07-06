resource "google_compute_network" "network" {
  name = "network"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "subnetwork"
  network       = google_compute_network.network.self_link
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_address" "main_runner_external_static" {
  name = "main-runner-external-static"
}

resource "google_compute_firewall" "docker_firewall" {
  name    = "docker-firewall"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["2376"]
  }

  source_tags = ["docker-machine"]
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
