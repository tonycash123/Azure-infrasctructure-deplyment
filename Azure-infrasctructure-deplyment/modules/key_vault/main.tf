resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Import",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]

    certificate_permissions = [
      "Get",
      "List",
      "Create",
      "Import",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]
  }
}
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_certificate" "ssl_cert" {
  name         = "ssl-cert"
  key_vault_id = var.key_vault_id
  
  certificate_policy {
    issuer_parameters {
      name = "Self"
    }
    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }
    lifetime_action {
      action {
        action_type = "AutoRenew"
      }
      trigger {
        days_before_expiry = 30
      }
    }
    secret_properties {
      content_type = "application/x-pkcs12"
    }
    x509_certificate_properties {
      key_usage = ["digitalSignature", "keyEncipherment"]
      subject            = "CN=app"
      validity_in_months = 12
    }
  }
}