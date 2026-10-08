output "firewall_id" {
  description = "Azure Firewall resource ID"
  value       = azurerm_firewall.this.id
}

output "firewall_name" {
  description = "Azure Firewall name"
  value       = azurerm_firewall.this.name
}

output "private_ip_address" {
  description = "Private IP address of Azure Firewall"
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "public_ip_address" {
  description = "Public IP address of Azure Firewall"
  value       = azurerm_public_ip.firewall.ip_address
}