resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id

  site_config {
    always_on = true  # Ensures that your web app is always running

    app_command_line = "npm start"  # Command to start your React app
  
    # Configure settings for serving static files
    cors {
      allowed_origins     = ["*"]  # Adjust as per your CORS requirements
      support_credentials = false  # Set to true if you need to allow credentials
    }
  }
}

