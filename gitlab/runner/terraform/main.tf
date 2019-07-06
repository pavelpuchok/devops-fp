data "google_compute_image" "main_runner_image_name" {
  family  = var.main_runner_image_family
  project = var.main_runner_image_project
}

resource "google_compute_instance" "main_runner_host" {
  name         = "main-runner"
  zone         = var.zone
  machine_type = var.main_runner_machine_type

  tags = var.main_runner_tags

  network_interface {
    subnetwork = google_compute_subnetwork.subnetwork.self_link

    access_config {
      nat_ip = google_compute_address.main_runner_external_static.address
    }
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.main_runner_image_name.self_link
    }
  }

  metadata = {
    ssh-keys = "appuser:${file(var.main_runner_ssh_key)}"
  }
}
