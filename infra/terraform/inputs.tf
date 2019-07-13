variable "credentials" {
  type        = "string"
  description = "Path to Google account credentials json file"
}

variable "project_id" {
  type        = "string"
  description = "GCP project id"
}

variable "ssh_key" {
  type        = "string"
  description = "SSH public key for accessing managed instances"
}

variable "dns_name" {
  type        = "string"
  description = "GCP DNS public name (domain name)"
}

variable "zone" {
  type        = "string"
  default     = "europe-west1-b"
  description = "GCP Zone"
}

variable "region" {
  type        = "string"
  default     = "europe-west1"
  description = "GCP Region"
}

variable "machine_name" {
  type        = "string"
  default     = "swarm-node"
  description = "GCP Machine Name Pattern"
}

variable "machine_type" {
  type        = "string"
  default     = "f1-micro"
  description = "GCP Machine Type"
}

variable "frontend_machine_type" {
  type        = "string"
  default     = "f1-micro"
  description = "GCP Machine Type for frontend instance"
}

variable "image_project" {
  type        = "string"
  default     = "ubuntu-os-cloud"
  description = "GCP image project"
}

variable "image_family" {
  type        = "string"
  default     = "ubuntu-1804-lts"
  description = "GCP image family"
}

variable "tags" {
  type        = list(string)
  default     = ["worker", "docker"]
  description = "GCP instance tags"
}

variable "tags_manager" {
  type        = list(string)
  default     = ["manager"]
  description = "GCP instance tags"
}

variable "tags_frontend" {
  type        = list(string)
  default     = ["http"]
  description = "GCP instance tags"
}

variable "network_name" {
  type        = "string"
  default     = "swarm-network"
  description = "GCP network name"
}

variable "subnetwork_name" {
  type        = "string"
  default     = "swarm-subnetwork"
  description = "GCP subnetwork name"
}

variable "subnetwork_range" {
  type        = "string"
  default     = "10.0.1.0/24"
  description = "GCP subnetwork range"
}

variable "external_address_name" {
  type        = "string"
  default     = "swarm-public-address"
  description = "GCP subnetwork range"
}

variable "dns_zone_name" {
  type        = "string"
  default     = "swarm-public-zone"
  description = "GCP DNS public zone name"
}

variable "bastion_instance_name" {
  type        = "string"
  default     = "bastion"
  description = "GCP DNS public zone name"
}

variable "bastion_instance_tag" {
  type        = "string"
  default     = "bastion"
  description = "GCP DNS public zone name"
}
