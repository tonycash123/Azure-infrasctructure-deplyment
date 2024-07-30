output "dns_zone_name" {
  value = azurerm_dns_zone.dns_zone_name.name
}

output "dns_zone_id" {
  value = azurerm_dns_zone.dns_zone_name.id
}

output "subdomain_name" {
  description = "The name of the subdomain."
  value       = azurerm_dns_a_record.subdomain.name
}