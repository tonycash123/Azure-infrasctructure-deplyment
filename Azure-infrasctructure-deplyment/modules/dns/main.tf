resource "azurerm_dns_zone" "dns_zone_name" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_a_record" "subdomain" {
  name                = var.subdomain
  zone_name           = azurerm_dns_zone.dns_zone_name.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [var.machine_ip]
}