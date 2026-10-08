module "resource_group" {
  source = "../../modules/resource-group"

  name     = "rg-azure-sr-lab-dev"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = "azure-senior-engineer-lab"
    ManagedBy   = "Terraform"
  }
}

module "networking" {
  source = "../../modules/networking"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  vnet_name          = "vnet-azure-sr-lab-dev"
  vnet_address_space = ["10.10.0.0/16"]

  aks_subnet_cidr              = "10.10.1.0/24"
  app_gateway_subnet_cidr      = "10.10.2.0/24"
  private_endpoint_subnet_cidr = "10.10.3.0/24"

  azure_firewall_subnet_cidr            = "10.10.4.0/26"
  azure_firewall_management_subnet_cidr = "10.10.4.64/26"
}

module "private_dns" {
  source = "../../modules/private-dns"

  resource_group_name   = module.resource_group.name
  private_dns_zone_name = "privatelink.vaultcore.azure.net"
  vnet_id               = module.networking.vnet_id
}

module "key_vault" {
  source = "../../modules/key-vault"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  key_vault_name = "kv-azsr-lab-dev-261006"

  tenant_id = data.azurerm_client_config.current.tenant_id

  private_endpoint_subnet_id = module.networking.private_endpoint_subnet_id
  private_dns_zone_id        = module.private_dns.private_dns_zone_id
}

module "aks" {
  source = "../../modules/aks"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  cluster_name = "aks-azure-sr-lab-dev"
  dns_prefix   = "aks-azure-sr-lab-dev"

  subnet_id = module.networking.aks_subnet_id

  node_count = 1
  vm_size    = "Standard_D2s_v4"

  tags = {
    Environment = var.environment
    Project     = "azure-senior-engineer-lab"
    ManagedBy   = "Terraform"
  }
}

module "application_gateway" {
  source = "../../modules/application-gateway"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  application_gateway_name = "appgw-azure-sr-lab-dev"
  public_ip_name           = "pip-appgw-azure-sr-lab-dev"

  subnet_id = module.networking.app_gateway_subnet_id

  tags = {
    Environment = var.environment
    Project     = "azure-senior-engineer-lab"
    ManagedBy   = "Terraform"
  }
}

module "azure_firewall" {
  source = "../../modules/azure-firewall"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  firewall_name  = "afw-azure-sr-lab-dev"
  public_ip_name = "pip-afw-azure-sr-lab-dev"

  firewall_subnet_id = module.networking.azure_firewall_subnet_id
  firewall_policy_id = module.firewall_policy.policy_id

  management_subnet_id      = module.networking.azure_firewall_management_subnet_id
  management_public_ip_name = "pip-afw-mgmt-azure-sr-lab-dev"

  tags = {
    Environment = var.environment
    Project     = "azure-senior-engineer-lab"
    ManagedBy   = "Terraform"
  }
}

module "route_table" {
  source = "../../modules/route-table"

  route_table_name    = "rt-aks-egress-dev"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  firewall_private_ip = module.azure_firewall.private_ip_address

  tags = {
    Environment = var.environment
    Project     = "azure-senior-engineer-lab"
    ManagedBy   = "Terraform"
  }
}

module "firewall_policy" {
  source = "../../modules/firewall-policy"

  policy_name         = "afwp-azure-sr-lab-dev"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  tags = {
    Environment = var.environment
    Project     = "azure-senior-engineer-lab"
    ManagedBy   = "Terraform"
  }
}