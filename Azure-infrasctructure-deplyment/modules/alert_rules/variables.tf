variable "resource_group_name" {
  description = "Name of the resource group where resources are located"
  type        = string
}

variable "action_group_id" {
  description = "ID of the Azure Action Group to trigger when alerts are fired"
  type        = string
}

variable "key_vault_id" {
  description = "The ID or name of the Azure Key Vault."
}

variable "app_service_id" {
  description = "The ID od the App Service"

}

variable "postgresql_id" {
  description = "ID of the PostgreSQL server"
  type        = string
}

variable "vm_id" {
  description = "ID of the Linux virtual machine"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "alert_criteria" {
  description = "Map of alert criteria thresholds"
  type        = map(any)
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  type = string
  
}