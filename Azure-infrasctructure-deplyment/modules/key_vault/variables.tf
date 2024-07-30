variable "key_vault_name" {
  type        = string
  description = "The name of the Key Vault"
}

variable "location" {
  type        = string
  description = "The Azure region where the Key Vault will be created"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Key Vault"
  
}