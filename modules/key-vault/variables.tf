variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the Key Vault private endpoint"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID for Key Vault"
  type        = string
}