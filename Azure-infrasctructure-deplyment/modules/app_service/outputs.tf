output "app_service_id" {
  description = "The ID of the App Service"
  value       = azurerm_linux_web_app.app_service.id
}