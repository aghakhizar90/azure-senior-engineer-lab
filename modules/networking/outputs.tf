output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "Virtual network resource ID"
  value       = azurerm_virtual_network.this.id
}

output "aks_subnet_id" {
  description = "AKS subnet resource ID"
  value       = azurerm_subnet.aks.id
}

output "app_gateway_subnet_id" {
  description = "Application Gateway subnet resource ID"
  value       = azurerm_subnet.app_gateway.id
}

output "private_endpoint_subnet_id" {
  description = "Private Endpoint subnet resource ID"
  value       = azurerm_subnet.private_endpoint.id
}

output "azure_firewall_subnet_id" {
  description = "Azure Firewall subnet resource ID"
  value       = azurerm_subnet.azure_firewall.id
}

output "azure_firewall_management_subnet_id" {
  description = "Azure Firewall management subnet resource ID"
  value       = azurerm_subnet.azure_firewall_management.id
}