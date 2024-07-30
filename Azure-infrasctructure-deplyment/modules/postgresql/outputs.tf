output "postgresql_server_name" {
  value = azurerm_postgresql_server.server.name
}

output "postgresql_database_ids" {
  value = azurerm_postgresql_database.databases[*].id
}

output "postgresql_id" {
  value = azurerm_postgresql_server.server.id
}