resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = {
    ManagedBy = "Terraform"
    Project   = "azure-senior-engineer-lab"
  }
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.aks_subnet_cidr]
}

resource "azurerm_subnet" "app_gateway" {
  name                 = "snet-appgw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.app_gateway_subnet_cidr]
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = "snet-private-endpoints"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.private_endpoint_subnet_cidr]
}

resource "azurerm_network_security_group" "aks" {
  name                = "nsg-aks"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    ManagedBy = "Terraform"
    Project   = "azure-senior-engineer-lab"
  }
}

resource "azurerm_network_security_group" "app_gateway" {
  name                = "nsg-appgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    ManagedBy = "Terraform"
    Project   = "azure-senior-engineer-lab"
  }
}

resource "azurerm_network_security_group" "private_endpoint" {
  name                = "nsg-private-endpoints"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    ManagedBy = "Terraform"
    Project   = "azure-senior-engineer-lab"
  }
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}

resource "azurerm_subnet_network_security_group_association" "app_gateway" {
  subnet_id                 = azurerm_subnet.app_gateway.id
  network_security_group_id = azurerm_network_security_group.app_gateway.id
}

resource "azurerm_subnet_network_security_group_association" "private_endpoint" {
  subnet_id                 = azurerm_subnet.private_endpoint.id
  network_security_group_id = azurerm_network_security_group.private_endpoint.id
}