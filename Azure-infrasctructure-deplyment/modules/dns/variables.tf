variable "dns_zone_name" {
  description = "The name of the DNS zone."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subdomain" {
  description = "The subdomain to create."
  type        = string
}

variable "machine_ip" {
  description = "The IP address of the machine."
  type        = string
}