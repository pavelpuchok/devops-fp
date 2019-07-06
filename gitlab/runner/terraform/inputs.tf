variable "project_id" {
  type        = "string"
  description = "GCP project id"
}

variable "main_runner_ssh_key" {
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

variable "main_runner_machine_type" {
  type        = "string"
  default     = "f1-micro"
  description = "GCP Machine Type for main runner instance"
}

variable "main_runner_image_project" {
  type        = "string"
  default     = "ubuntu-os-cloud"
  description = "Main runner GCP image project"
}

variable "main_runner_image_family" {
  type        = "string"
  default     = "ubuntu-1804-lts"
  description = "Main runner GCP image family"
}

variable "main_runner_tags" {
  type        = list(string)
  default     = ["gitlab-runner", "gitlab-main-runner", "docker", "docker-machine", "ssh"]
  description = "Main runner GCP image family"
}

