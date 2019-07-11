variable "address_name" {
  type        = "string"
  description = "External address GCP resource name"
}

variable "instance_name" {
  type        = "string"
  description = "GCP instance name"
}

variable "machine_type" {
  type        = "string"
  description = "GCP instance machine type"
}

variable "zone" {
  type        = "string"
  description = "GCP instance zone"
}

variable "tag" {
  type        = "string"
  description = "Bastion instance tag"
}

variable "network" {
  type        = "string"
  description = "GCP network self_link"
}

variable "subnetwork" {
  type        = "string"
  description = "GCP subnetwork self_link"
}

variable "disk_image" {
  type        = "string"
  description = "GCP image name, family or self_link for instance"
}

variable "ssh_keys" {
  type        = "string"
  description = "Instance SSH keys in format <username>:<sshkey>;<username><sshkey>"
}

variable "http_firewall_name" {
  type        = "string"
  description = "GCP firewall rule name"
}

variable "source_ranges" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Source range to access HTTP(S) ports"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Should or not to create resources."
}
