variable "resource_group_name" {
  description = "Resource group containing Application Gateway"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "application_gateway_name" {
  description = "Application Gateway name"
  type        = string
}

variable "subnet_id" {
  description = "Dedicated subnet ID for Application Gateway"
  type        = string
}

variable "public_ip_name" {
  description = "Public IP name for Application Gateway"
  type        = string
}

variable "tags" {
  description = "Tags applied to Application Gateway resources"
  type        = map(string)
  default     = {}
}