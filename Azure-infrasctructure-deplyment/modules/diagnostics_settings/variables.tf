variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  type        = string
}

variable "app_service_id" {
  description = "ID of the App Service"
  type        = string
}

variable "vm_id" {
  description = "ID of the Virtual Machine"
  type        = string
}

variable "postgresql_id" {
  description = "ID of the PostgreSQL Server"
  type        = string
}

variable "app_service_diagnostics_name" {
  description = "Name for App Service diagnostics setting"
  type        = string
}

variable "vm_diagnostics_name" {
  description = "Name for Virtual Machine diagnostics setting"
  type        = string
}

variable "postgresql_diagnostics_name" {
  description = "Name for PostgreSQL diagnostics setting"
  type        = string
}
