resource "azurerm_public_ip" "firewall" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_public_ip" "firewall_management" {
  name                = var.management_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = "AZFW_VNet"
  sku_tier = "Basic"
  firewall_policy_id = var.firewall_policy_id

  ip_configuration {
    name                 = "firewall-ip-configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }

  management_ip_configuration {
    name                 = "firewall-management-ip-configuration"
    subnet_id            = var.management_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_management.id
  }

  tags = var.tags
}