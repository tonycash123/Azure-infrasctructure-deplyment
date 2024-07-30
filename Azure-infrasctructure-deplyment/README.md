Here is the updated README file with the requested changes:

---

# Azure Terraform Infrastructure for On-Prem

This repository contains the Terraform configuration files for setting up the On-Prem infrastructure on Azure.

## Prerequisites

Before running this code, make sure you have the following prerequisites:

- Azure Service Principal credentials
- Terraform 1.8.3
- Azure CLI

## Local Environment Setup

Follow these steps to set up the project:

1. **Install Azure CLI**: Make sure you have the Azure CLI installed on your local machine.
2. **Initialize Azure CLI with credentials**: Authenticate the Azure CLI with your Azure credentials.

## Configuration Variables (`dev.tfvars`)

Here's a brief description of the variables in the `dev.tfvars` file:

- `resource_group_name`: The name of the resource group.
- `location`: The location for the resource group and resources.
- `create_new_resource_group`: A flag to create a new resource group.
- `vnet_name`: The name of the virtual network.
- `vnet_address_space`: The address space for the virtual network.
- `network_interface_id`: The ID of the network interface.
- `subnet_name`: The name of the subnet.
- `subnet_address_prefix`: The address prefix for the subnet.
- `vm_name`: The name of the virtual machine.
- `vm_size`: The size of the virtual machine.
- `admin_username`: The administrator username for the virtual machine.
- `registry_name`: The name of the Azure Container Registry.
- `pg_server_name`: The name of the PostgreSQL server.
- `pg_databases`: A list of databases to be created on the PostgreSQL server.
- `dns_zone_name`: The name of the DNS zone.
- `public_ip_name`: The name of the public IP.
- `lb_name`: The name of the load balancer.
- `container_group_name`: The name of the container group.
- `container_name`: The name of the container.
- `image`: The container image.
- `cpu`: The number of CPUs for the container.
- `memory`: The memory allocation for the container.
- `port`: The port for the container.
- `source_code_path`: The path to the source code.
- `key_vault_name`: The name of the Azure Key Vault.
- `postgres_administrator_login`: The PostgreSQL administrator login username.
- `postgres_administrator_login_password`: The PostgreSQL administrator login password.
- `use_existing_secret`: A flag to use an existing secret from Azure Key Vault.
- `use_generate_secret`: A flag to generate a new secret.
- `existing_username_secret_name`: The name of the existing secret containing the PostgreSQL username.
- `existing_password_secret_name`: The name of the existing secret containing the PostgreSQL password.
- `app_service_name`: The name of the app service.
- `app_service_plan_name`: The name of the app service plan.
- `action_group_name`: The name of the action group for alerts.
- `action_group_short_name`: The short name of the action group for alerts.
- `http_server_errors`: The threshold for HTTP server errors.
- `app_service_downtime`: The threshold for app service downtime.
- `postgresql_deadlocks`: The threshold for PostgreSQL deadlocks.
- `postgresql_slow_queries`: The threshold for PostgreSQL slow queries.
- `key_expiration`: The threshold for key expiration (days).
- `app_service_slow_response`: The threshold for app service slow response (ms).
- `log_analytics_workspace_name`: The name of the Log Analytics workspace.
- `app_service_diagnostics_name`: The name of the app service diagnostics.
- `postgresql_diagnostics_name`: The name of the PostgreSQL diagnostics.
- `vm_diagnostics_name`: The name of the VM diagnostics.
- `postgresql_slow_queries_alert_name`: The name of the alert for slow PostgreSQL queries.
- `postgresql_deadlocks_alert_name`: The name of the alert for PostgreSQL deadlocks.
- `linux_vm_downtime`: The name of the alert for Linux VM downtime.
- `email_receivers`: A list of email receivers for alerts.
- `alert_criteria`: Criteria for various alerts.
- `subdomain`: The name of the subdomain to route the machine's IP.
- `ssl_certificates`: To manage SSL certificates in Azure.

## Variable Details

### `use_generate_secret`
- **Description:** A flag to generate a new secret.
- **Type:** bool
- **Default:** true

### `use_existing_secret`
- **Description:** A flag to use an existing secret from Azure Key Vault.
- **Type:** bool
- **Default:** false

### `postgres_administrator_login`
- **Description:** The PostgreSQL administrator login username.
- **Type:** string

### `postgres_administrator_login_password`
- **Description:** The PostgreSQL administrator login password.
- **Type:** string

### `existing_username_secret_name`
- **Description:** The name of the existing secret containing the PostgreSQL username.
- **Type:** string

### `existing_password_secret_name`
- **Description:** The name of the existing secret containing the PostgreSQL password.
- **Type:** string

### `key_vault_name`
- **Description:** The name of the Azure Key Vault.
- **Type:** string

### `pg_server_name`
- **Description:** The name of the PostgreSQL server.
- **Type:** string

### `location`
- **Description:** The location for the resource group and resources.
- **Type:** string

### `resource_group_name`
- **Description:** The name of the resource group.
- **Type:** string

### `pg_databases`
- **Description:** A list of databases to be created on the PostgreSQL server.
- **Type:** list(string)

 ### subdomain
- **Description:** The name of the subdomain to route the machine's IP.
- **Type:**  string

### ssl_certificates
- **Description:**A flag to manage SSL certificates in Azure.
- **Type:** : bool

## How to Use

1. Update the `dev.tfvars` file with your specific configuration values.
2. Run `terraform init -backend-config='dev.config'`.
3. Run `terraform plan -var-file=dev.tfvars` to see the changes that will be made.
4. Run `terraform apply -var-file=dev.tfvars` to apply the changes.

Please ensure you have the necessary permissions and the Azure CLI installed and configured before running these commands.

## CI/CD

All changes are applied in the CI. On EVERY Pull Request, the version should be bumped (patch if no other changes are required).

- **On a PR**: `init` & `plan` are run on CI without `apply`.
- **On merge of PR to main**: `init`, `plan` & `apply` are run on Insait's Azure subscription (dev).

## Modules

This repository contains several modules, each responsible for creating a specific resource in Azure. These modules include:

- `linux_virtual_machine`: Creates a Linux virtual machine.
- `container_registry`: Creates an Azure Container Registry.
- `postgresql`: Creates a PostgreSQL server and databases.
- `dns`: Creates a DNS zone.
- `virtual_network`: Creates a virtual network.
- `subnet`: Creates a subnet within the virtual network.
- `resource_group`: Creates a resource group to deploy the infrastructure.
- `app_service_plan`: Sets up the Azure App Service Plan.
- `app_service`: Configures the Azure App Service using the defined App Service Plan.
- `action_group`: Defines an Azure Action Group for alert notifications.
- `alert_rules`: Configures alert rules for monitoring various metrics across Azure resources.
- `log_analytics_workspace`: Creates an Azure Log Analytics Workspace for centralized logging.
- `diagnostics_settings`: Configures diagnostics settings for App Service, VMs, and PostgreSQL.

## Key Vault and Secrets Management

This configuration includes the management of Azure Key Vault and secrets with the following resources:

- `random_password.generated_password`: Generates a random password with special characters.
- `random_string.generated_username`: Generates a random username without special characters.
- `azurerm_key_vault_secret.postgres_username_secret`: Stores the PostgreSQL admin username in the Key Vault.
- `azurerm_key_vault_secret.postgres_password_secret`: Stores the PostgreSQL admin password in the Key Vault.
- `azurerm_key_vault_secret`: Retrieves an existing secret from the Key Vault.

## Administrator Credentials and Secret Options

The following variables allow you to manage the administrator credentials and secrets:

- `postgres_administrator_login`: The PostgreSQL admin login username retrieved from Azure Key Vault or provided directly.
- `postgres_administrator_login_password`: The PostgreSQL admin login password retrieved from Azure Key Vault or provided directly.

### Usage

The configuration uses the following variables:
- `var.use_generate_secret`: Set this variable to `true` to generate new PostgreSQL administrator credentials using `random_string.generated_username.result` for username and `random_password.generated_password.result` for password. Set it to `false` to use the provided credentials (`var.postgres_administrator_login` for username and `var.postgres_administrator_login_password` for password).
  
- `var.use_existing_secret`: Set this variable to `true` to use existing PostgreSQL administrator credentials stored in Azure Key Vault. This condition determines whether the resources for creating new secrets (`azurerm_key_vault_secret.postgres_username_secret` and `azurerm_key_vault_secret.postgres_password_secret`) will be skipped (`count = 0`).

- ## Subdomain and SSL Certificates Management
  Subdomain Configuration
`To configure a subdomain and route the machine's IP to this subdomain, use the following variable`:

`subdomain_name: The name of the subdomain to route`

## SSL Certificates Management
To manage SSL certificates in Azure, use the following variable:

`ssl_certificates`: variable for SSL certificates in Azure.
