variable "dns_name" {
  type        = "string"
  description = "DNS name with followed dot. For ex. example.com."
}

variable "address" {
  type        = "string"
  description = "address for DNS"
}

variable "dns_zone_name" {
  type        = "string"
  description = "GCP DNS public zone name"
}

variable "ttl" {
  type        = number
  default     = 300
  description = "DNS TTL"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Should or not to create resources."
}
