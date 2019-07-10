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
  default     = ["manager", "worker", "docker", "ssh"]
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
