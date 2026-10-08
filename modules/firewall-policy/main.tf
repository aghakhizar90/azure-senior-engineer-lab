resource "azurerm_firewall_policy" "this" {
  name                = var.policy_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"

  tags = var.tags
}

resource "azurerm_firewall_policy_rule_collection_group" "this" {
  name               = "rcg-aks-egress-dev"
  firewall_policy_id = azurerm_firewall_policy.this.id
  priority           = 200

  application_rule_collection {
    name     = "arc-aks-web-egress"
    priority = 200
    action   = "Allow"

    rule {
      name = "allow-aks-microsoft-endpoints"

      source_addresses = [
        "10.10.1.0/24"
      ]

      destination_fqdn_tags = [
        "AzureKubernetesService"
      ]

      protocols {
        type = "Https"
        port = 443
      }
    }
  }
}