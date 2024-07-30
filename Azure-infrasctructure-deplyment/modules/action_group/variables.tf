variable "action_group_name" {
  description = "The name of the Action Group"
  type        = string
}

variable "action_group_short_name" {
  description = "The short name of the Action Group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "email_receivers" {
  description = "List of email receivers"
  type = list(object({
    name          = string
    email_address = string
  }))
}
