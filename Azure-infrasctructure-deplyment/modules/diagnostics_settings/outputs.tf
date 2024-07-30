output "app_service_diagnostic_setting_id" {
  value = azurerm_monitor_diagnostic_setting.app_service_diagnostics.id
}

output "vm_diagnostic_setting_id" {
  value = azurerm_monitor_diagnostic_setting.vm_diagnostics.id
}

output "postgresql_diagnostic_setting_id" {
  value = azurerm_monitor_diagnostic_setting.postgresql_diagnostics.id
}
