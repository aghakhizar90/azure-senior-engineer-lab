variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "aks_subnet_cidr" {
  description = "CIDR range for AKS subnet"
  type        = string
}

variable "app_gateway_subnet_cidr" {
  description = "CIDR range for Application Gateway subnet"
  type        = string
}

variable "private_endpoint_subnet_cidr" {
  description = "CIDR range for Private Endpoint subnet"
  type        = string
}