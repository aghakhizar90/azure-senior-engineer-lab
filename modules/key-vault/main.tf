resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  public_network_access_enabled = false

  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = {
    ManagedBy = "Terraform"
    Project   = "azure-senior-engineer-lab"
  }
}

resource "azurerm_private_endpoint" "key_vault" {
  name                = "pe-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "psc-keyvault"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "key-vault-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = {
    ManagedBy = "Terraform"
    Project   = "azure-senior-engineer-lab"
  }
}