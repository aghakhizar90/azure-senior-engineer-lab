# Azure Senior Engineer Lab

Terraform infrastructure for a small Azure development environment. It creates a resource group, a virtual network, a private Key Vault, and an Azure Kubernetes Service (AKS) cluster. The `environments/dev` directory is the deployable Terraform root; shared infrastructure is implemented as reusable modules.

## What Gets Created

| Area | Resources and configuration |
| --- | --- |
| Resource group | `rg-azure-sr-lab-dev` in East US; environment and project tags |
| Network | `vnet-azure-sr-lab-dev` (`10.10.0.0/16`) with AKS (`10.10.1.0/24`), Application Gateway (`10.10.2.0/24`), and private endpoint (`10.10.3.0/24`) subnets; an NSG is associated with each subnet |
| AKS | `aks-azure-sr-lab-dev`, one `Standard_D2s_v4` system node, system-assigned identity, Azure CNI and Azure network policy |
| Key Vault | Standard vault with public network access disabled, connected to the VNet through a private endpoint |
| Private DNS | `privatelink.vaultcore.azure.net`, linked to the VNet and associated with the Key Vault private endpoint |

The Application Gateway subnet is reserved for future use; this configuration does not create an Application Gateway or deploy Kubernetes workloads. The NSGs have no custom rules, so Azure's default NSG rules apply. AKS is not configured as a private cluster.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `environments/dev/` | Development environment root: provider, variables, and module composition |
| `modules/resource-group/` | Resource group |
| `modules/networking/` | Virtual network, subnets, NSGs, and subnet associations |
| `modules/aks/` | AKS cluster and node pool |
| `modules/key-vault/` | Key Vault and private endpoint |
| `modules/private-dns/` | Private DNS zone and VNet link |
| `bootstrap/` | Reserved for setup/bootstrap files; currently empty |

## Deploy

Prerequisites: Terraform `>= 1.9`, Azure CLI, an Azure subscription with permissions to create these resources, and `kubectl` for cluster access. Terraform uses the AzureRM provider `~> 4.0` and Azure CLI authentication.

```bash
az login
az account set --subscription "<subscription-id-or-name>"
cd environments/dev
terraform init
terraform validate
terraform plan
terraform apply
```

After applying, connect to AKS and check the node:

```bash
az aks get-credentials --resource-group rg-azure-sr-lab-dev --name aks-azure-sr-lab-dev
kubectl get nodes
```

To remove the environment, run `terraform destroy` from `environments/dev` after confirming the plan. `az aks stop` stops the cluster's compute but does not remove the other Azure resources; use Terraform destroy when the whole lab should be removed.

## Notes

- Terraform state is local; no remote backend is configured. Keep state private and do not commit it.
- The Key Vault name (`kv-azsr-lab-dev-261006`) is set in the dev configuration and must be globally unique in Azure. Change it if Azure reports a name conflict.
- Key Vault public access is disabled, so clients need network access to the VNet/private endpoint to reach the vault.
