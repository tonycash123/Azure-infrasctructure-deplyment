resource_group_name       = "Testing"
location                  = "eastus"
create_new_resource_group = false

# Networking
vnet_name            = "vnet"
vnet_address_space   = ["10.0.0.0/16"]
network_interface_id = "nic"

subnet_name           = "subnet"
subnet_address_prefix = "10.0.1.0/24"


# Virtual Machine
vm_name        = "vm"
vm_size        = "Standard_B4ms"
admin_username = "Admin"

# Azure Container Registry (ACR)
registry_name = "containerregistry"

# PostgreSQL Server
pg_server_name = "pgserver"
pg_databases   = ["backend", "metabase", "bank_db"]

# Azure Domain name, Subdomain, and Key Vault Certificate
dns_zone_name = "edulyncx.com"
subdomain     = "sub"

# Public IP and Load Balancer
public_ip_name = "PublicIP"
lb_name        = "LoadBalancer"

# Container Group and Container
container_group_name = "ContainerGroup"
container_name       = "Container"
image                = "nginx:latest"
cpu                  = 1
memory               = 1
port                 = 80

# Source Code Path
source_code_path = "/path/to/your/source/code"

#key vault
key_vault_name = "keyvaultprem"

# Administrator credentials and secret options
postgres-administrator-login          = "insaitpgadmin12"
postgres-administrator-login-password = "hP7-MH1o-AOL5B4N20fe12"
use_existing_secret                   = false
use_generate_secret                   = true

existing_username_secret_name = "postgres-administrator-username"
existing_password_secret_name = "postgres-administrator-password"


app_service_name                   = "App-Service"
app_service_plan_name              = "App-Service-plan"
action_group_name                  = "email-notifications"
action_group_short_name            = "email-alerts"
log_analytics_workspace_name       = "LogAnalytics-Workspace"
app_service_diagnostics_name       = "app-service-diagnostics"
postgresql_diagnostics_name        = "postgresql-diagnostics"
vm_diagnostics_name                = "vm-diagnostics"

email_receivers = [
  {
    name          = "Ahmad"
    email_address = "Ahmad@gmail.com"
  },
  {
    name          = "Victor"
    email_address = "victor@gmail.com"
  },
  {
    name          = "Tony"
    email_address = "tony@gmail.com"
  }
]

# Alert Criteria
alert_criteria = {
  deadlocks = {
    threshold = 1
  },
  slow_queries = {
    threshold = 10
  }
}

