data "google_compute_image" "image_name" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_instance" "instance" {
  name         = var.machine_name
  zone         = var.zone
  machine_type = var.machine_type

  tags = var.tags

  network_interface {
    subnetwork = google_compute_subnetwork.subnetwork.self_link

    access_config {
      nat_ip = google_compute_address.external_static.address
    }
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image_name.self_link
    }
  }

  metadata = {
    ssh-keys = "appuser:${file(var.ssh_key)}"
  }
}
