terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "1.13.1"
    }
  }
  backend "azurerm" {
    container_name = "tfstate"
    key            = "terraform.tfstate"
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
  
}

provider "azapi" {}


module "virtual_network" {
  source              = "./modules/virtual_network"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
}

module "subnet" {
  source              = "./modules/subnet"
  resource_group_name = var.resource_group_name
  vnet_name           = module.virtual_network.vnet_name
  subnet_name         = var.subnet_name
  address_prefix      = var.subnet_address_prefix
}

module "linux_virtual_machine" {
  source               = "./modules/linux_virtual_machine"
  resource_group_name = var.resource_group_name
  location             = var.location
  vm_name              = var.vm_name
  vm_size              = var.vm_size
  subnet_id            = module.subnet.subnet_id
  admin_username       = var.admin_username
  network_interface_id = var.network_interface_id
}

module "container_registry" {
  source              = "./modules/container_registry"
  resource_group_name = var.resource_group_name
  location            = var.location
  registry_name       = var.registry_name
}

module "postgresql" {
  source                     = "./modules/postgresql"
  server_name                = var.pg_server_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  postgres-administrator-login = module.key_vault_secrets.postgres_administrator_username
  postgres-administrator-login-password = module.key_vault_secrets.postgres_administrator_password
  databases                  = var.pg_databases
}

module "dns" {
  source              = "./modules/dns"
  resource_group_name = var.resource_group_name
  dns_zone_name = var.dns_zone_name
  subdomain = var.subdomain
  machine_ip = module.linux_virtual_machine.public_ip

}

module "resource_group" {
  source                    = "./modules/resource_group"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  create_new_resource_group = var.create_new_resource_group
}


module "load_balancer" {
  source = "./modules/load_balancer"
  resource_group_name = var.resource_group_name
  location = var.location
  lb_name = var.lb_name
  public_ip_name = var.public_ip_name
  
}

module "key_vault" {
  source              = "./modules/key_vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_name      = var.key_vault_name
  key_vault_id = module.key_vault.key_vault_id
}

module "key_vault_secrets" {
  source                     = "./modules/key_vault_secrets"
  use_generate_secret        = var.use_generate_secret
  use_existing_secret        = var.use_existing_secret
  key_vault_id               =  module.key_vault.key_vault_id
  existing_username_secret_name = var.existing_username_secret_name
  existing_password_secret_name = var.existing_password_secret_name
   postgres-administrator-login = var.postgres-administrator-login
  postgres-administrator-login-password = var.postgres-administrator-login-password
}


module "app_service_plan" {
  source                = "./modules/app_service_plan"
  app_service_plan_name = var.app_service_plan_name
  resource_group_name   = var.resource_group_name
  location              = var.location
}

module "app_service" {
  source              = "./modules/app_service"
  app_service_name    = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  app_service_plan_id = module.app_service_plan.app_service_plan_id
}

module "action_group" {
  source                  = "./modules/action_group"
  action_group_name       = var.action_group_name
  resource_group_name     = var.resource_group_name
  action_group_short_name = var.action_group_short_name
  email_receivers         = var.email_receivers
}

module "alert_rules" {
  source                             = "./modules/alert_rules"
  location                           = var.location
  resource_group_name                = var.resource_group_name
  action_group_id                    = module.action_group.action_group_id
  vm_id                            = module.linux_virtual_machine.vm_id
  log_analytics_workspace_id         = module.log_analytics_workspace.log_analytics_workspace_id
  app_service_id                     = module.app_service.app_service_id
  postgresql_id                      = module.postgresql.postgresql_id
  key_vault_id                       = module.key_vault.key_vault_id
  alert_criteria                     = var.alert_criteria
}


module "log_analytics_workspace" {
  source                       = "./modules/log_analytics_workspace"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  log_analytics_workspace_name = var.log_analytics_workspace_name
}

module "diagnostics_settings" {
  source                       = "./modules/diagnostics_settings"
  app_service_id               = module.app_service.app_service_id
  vm_id                        = module.linux_virtual_machine.vm_id
  postgresql_id                = module.postgresql.postgresql_id
  log_analytics_workspace_id   = module.log_analytics_workspace.log_analytics_workspace_id
  app_service_diagnostics_name = var.app_service_diagnostics_name
  vm_diagnostics_name          = var.vm_diagnostics_name
  postgresql_diagnostics_name  = var.postgresql_diagnostics_name
}
