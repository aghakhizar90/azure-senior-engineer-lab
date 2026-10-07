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