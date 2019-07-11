data "google_compute_image" "image_name" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_instance" "instance" {
  name         = "${terraform.workspace}-${var.machine_name}"
  zone         = var.zone
  machine_type = var.machine_type

  tags = formatlist("${terraform.workspace}-%s", var.tags)

  network_interface {
    subnetwork = google_compute_subnetwork.subnetwork.self_link
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image_name.self_link
    }
  }
}

resource "google_compute_instance" "frontend" {
  name         = "frontend-instance"
  zone         = var.zone
  machine_type = var.frontend_machine_type
  tags = formatlist("${terraform.workspace}-%s", var.tags)
  count = terraform.workspace == "production" ? 1 : 0

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


module "bastion" {
  source = "modules/bastion"
  zone   = var.zone
  instance_name = var.bastion_instance_name
  machine_type = var.machine_type
  network = google_compute_network.network.self_link
  subnetwork = google_compute_subnetwork.subnetwork.self_link
  tag = var.bastion_instance_tag
  image = data.google_compute_image.image_name.self_link
  external_address_name = "bastion-external-static"
  ssh_keys = "appuser:${file(var.ssh_key)}"
  ssh_firewall_name = "bastion-ssh"
}

module "dns" {
  source = "modules/dns"
  dns_name = var.dns_name
  dns_zone_name = var.dns_zone_name
  address = google_compute_address.external_static.address
  count = terraform.workspace == "production" ? 1 : 0
}
