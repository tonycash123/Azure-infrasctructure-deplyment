# HTTP server errors for App Services
resource "azurerm_monitor_metric_alert" "http_server_errors" {
  name                = "http_server_errors"
  resource_group_name = var.resource_group_name
  scopes              = [var.app_service_id]
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    operator         = "GreaterThan"
    threshold        = 100
    aggregation      = "Total"
  }
  action {
    action_group_id = var.action_group_id
  }
}

# Downtime for App Services
resource "azurerm_monitor_metric_alert" "app_service_downtime" {
  name                = "app_service_downtime"
  resource_group_name = var.resource_group_name
  scopes              = [var.app_service_id]
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http2xx"
    operator         = "LessThan"
    threshold        = 1
    aggregation      = "Total"
  }
  action {
    action_group_id = var.action_group_id
  }
}

# Expiration Dates for Managed Keys
resource "azurerm_monitor_activity_log_alert" "key_expiration" {
  name                = "key_expiration"
  resource_group_name = var.resource_group_name
  scopes              = [var.key_vault_id]
  criteria {
    category       = "Administrative"
    operation_name = "Microsoft.KeyVault/vaults/read"
  }
  action {
    action_group_id = var.action_group_id
  }
}

# Slow Response Times for App Services
resource "azurerm_monitor_metric_alert" "app_service_slow_response" {
  name                = "app_service_slow_response"
  resource_group_name = var.resource_group_name
  scopes              = [var.app_service_id]
  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "AverageResponseTime"
    operator         = "GreaterThan"
    threshold        = 2000 # Example threshold in milliseconds (2 seconds)
    aggregation      = "Average"
  }
  action {
    action_group_id = var.action_group_id
  }
}

resource "azurerm_monitor_metric_alert" "linux_vm_downtime" {
  name                = "linux_vm_downtime"
  resource_group_name = var.resource_group_name
  scopes              = [var.vm_id]
 
  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThanOrEqual"
    threshold        = 95
   
  }
  
  action {
    action_group_id = var.action_group_id
  }

}

resource "azurerm_monitor_scheduled_query_rules_alert" "deadlocks_alert" {
  name                = "postgresql_deadlocks_alert_name"
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "Alert for PostgreSQL deadlocks"
  severity            = 2
  enabled             = true
  frequency           = 5  # The query runs every 5 minutes
  time_window         = 15 # The query looks at the data from the past 15 minutes
  data_source_id      = var.log_analytics_workspace_id

  action {
    action_group = [var.action_group_id]
  }

  query = <<-QUERY
        AzureDiagnostics 
        | where ResourceId == "${var.postgresql_id}"
        | where OperationName == "deadlock"
        | summarize count() by bin(TimeGenerated, 15m)
        | where count_ > ${var.alert_criteria["deadlocks"]["threshold"]}
      QUERY
  trigger {
    operator  = "GreaterThan"
    threshold = 0 # Example threshold for detecting any deadlock

  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "slow_queries_alert" {
  name                = "postgresql_slow_queries_alert_name"
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "Alert for PostgreSQL slow queries"
  severity            = 3
  enabled             = true
  frequency           = 5  # The query runs every 5 minutes
  time_window         = 15 # The query looks at the data from the past 15 minutes
  data_source_id      = var.log_analytics_workspace_id

   action {
    action_group = [var.action_group_id]
  }



  query = <<-QUERY
        AzureDiagnostics 
        | where ResourceId == "${var.postgresql_id}"
        | where OperationName == "query"
        | where DurationMs > 1000 // Adjust the threshold for slow queries
        | summarize count() by bin(TimeGenerated, 15m)
        | where count_ > ${var.alert_criteria["slow_queries"]["threshold"]}
      QUERY
  trigger {
    operator  = "GreaterThan"
    threshold = 1000 # Example threshold in milliseconds
  }
}



