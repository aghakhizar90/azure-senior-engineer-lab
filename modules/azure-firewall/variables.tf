variable "resource_group_name" {
  description = "Resource group containing Azure Firewall"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "firewall_name" {
  description = "Name of the Azure Firewall"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Azure Firewall public IP"
  type        = string
}

variable "firewall_subnet_id" {
  description = "Resource ID of AzureFirewallSubnet"
  type        = string
}

variable "tags" {
  description = "Tags applied to Azure Firewall resources"
  type        = map(string)
  default     = {}
}

variable "management_subnet_id" {
  description = "Resource ID of AzureFirewallManagementSubnet"
  type        = string
}

variable "management_public_ip_name" {
  description = "Name of Azure Firewall management public IP"
  type        = string
}

variable "firewall_policy_id" {
  description = "ID of the Azure Firewall Policy"
  type        = string
}