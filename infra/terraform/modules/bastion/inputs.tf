variable "zone" {
  type        = "string"
  description = "GCP Zone"
}

variable "instance_name" {
  type        = "string"
  description = "Bastion GCP instance name"
}

variable "machine_type" {
  type        = "string"
  description = "GCP machine type for bastion instance"
}

variable "network" {
  type        = "string"
  description = "GCP network name or self_link"
}

variable "subnetwork" {
  type        = "string"
  description = "GCP subnetwork name or self_link"
}

variable "tag" {
  type        = "string"
  description = "Bastion instance tag"
}

variable "image" {
  type        = "string"
  description = "GCP instance image name, family or self_Link"
}

variable "ssh_keys" {
  type        = "string"
  description = "SSH keys to access bastion in format <username>:<ssh_key>;<username>:<ssh_key>"
}

variable "ssh_firewall_name" {
  type        = "string"
  description = "SSH firwall name"
}

variable "ssh_port" {
  type        = "string"
  default     = "22"
  description = "SSH port"
}

variable "source_ranges" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Source range to access bastion SSH port"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Should or not to create resources."
}
