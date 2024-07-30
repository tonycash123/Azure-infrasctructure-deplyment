output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}

output "certificate_secret_id" {
  description = "The secret ID of the SSL certificate."
  value       = azurerm_key_vault_certificate.ssl_cert.secret_id
}
