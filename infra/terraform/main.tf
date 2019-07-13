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

  metadata = {
    ssh-keys = "appuser:${file(var.ssh_key)}"
  }
}

module "frontend" {
  source             = "./modules/frontend"
  address_name       = "frontend-static-address"
  instance_name      = "frontend"
  machine_type       = var.machine_type
  zone               = var.zone
  tag                = "frontend"
  network            = google_compute_network.network.self_link
  subnetwork         = google_compute_subnetwork.subnetwork.self_link
  disk_image         = data.google_compute_image.image_name.self_link
  ssh_keys           = "appuser:${file(var.ssh_key)}"
  http_firewall_name = "http-frontend"
  enabled            = terraform.workspace == "production"
}

module "bastion" {
  source            = "./modules/bastion"
  zone              = var.zone
  instance_name     = var.bastion_instance_name
  machine_type      = var.machine_type
  network           = google_compute_network.network.self_link
  subnetwork        = google_compute_subnetwork.subnetwork.self_link
  tag               = var.bastion_instance_tag
  image             = data.google_compute_image.image_name.self_link
  ssh_keys          = "appuser:${file(var.ssh_key)}"
  ssh_firewall_name = "bastion-ssh"
  enabled           = terraform.workspace == "production"
}

module "dns" {
  source        = "./modules/dns"
  dns_name      = var.dns_name
  dns_zone_name = var.dns_zone_name
  address       = module.frontend.frontend_address
  enabled       = terraform.workspace == "production"
}
