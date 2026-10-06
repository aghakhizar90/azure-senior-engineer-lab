output "key_vault_id" {
  description = "Key Vault resource ID"
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.this.name
}

output "private_endpoint_id" {
  description = "Key Vault private endpoint ID"
  value       = azurerm_private_endpoint.key_vault.id
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.this.vault_uri
}