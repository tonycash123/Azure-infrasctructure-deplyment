resource "azurerm_monitor_diagnostic_setting" "app_service_diagnostics" {
  name                       = var.app_service_diagnostics_name
  target_resource_id         = var.app_service_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AppServiceHTTPLogs"

  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "vm_diagnostics" {
  name                       = var.vm_diagnostics_name
  target_resource_id         = var.vm_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "postgresql_diagnostics" {
  name                       = var.postgresql_diagnostics_name
  target_resource_id         = var.postgresql_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "PostgreSQLLogs"

  }

  metric {
    category = "AllMetrics"
    enabled  = true

  }
}
