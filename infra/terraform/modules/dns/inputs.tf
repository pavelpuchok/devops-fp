variable "dns_name" {
  type        = "string"
  description = "DNS name"
}

variable "address" {
  type        = "string"
  description = "address for DNS"
}

variable "dns_zone_name" {
  type        = "string"
  description = "GCP DNS public zone name"
}

variable "count" {
  type        = "number"
  default     = 1
  description = "Count of all resource. Set to 0 if should not be created"
}

variable "ttl" {
  type        = "number"
  default     = 300
  description = "DNS TTL"
}