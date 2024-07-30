output "http_server_errors_alert_id" {
  description = "The ID of the HTTP server errors alert for the App Service."
  value       = azurerm_monitor_metric_alert.http_server_errors.id
}

output "app_service_downtime_alert_id" {
  description = "The ID of the downtime alert for the App Service."
  value       = azurerm_monitor_metric_alert.app_service_downtime.id
}

output "key_expiration_alert_id" {
  description = "The ID of the expiration dates alert for managed keys in Key Vault."
  value       = azurerm_monitor_activity_log_alert.key_expiration.id
}

output "app_service_slow_response_alert_id" {
  description = "The ID of the slow response times alert for the App Service."
  value       = azurerm_monitor_metric_alert.app_service_slow_response.id
}

output "linux_vm_downtime_alert_id" {
  description = "The ID of the downtime alert for the Linux VM."
  value       = azurerm_monitor_metric_alert.linux_vm_downtime.id
}

output "deadlocks_alert_id" {
  description = "The ID of the deadlocks alert for PostgreSQL."
  value       = azurerm_monitor_scheduled_query_rules_alert.deadlocks_alert.id
}

output "slow_queries_alert_id" {
  description = "The ID of the slow queries alert for PostgreSQL."
  value       = azurerm_monitor_scheduled_query_rules_alert.slow_queries_alert.id
}
