# Private DNS Resolver Module

## Overview

This module deploys and manages Azure Private DNS Resolver resources using Terraform. It provisions the necessary components to enable DNS resolution and forwarding within your Azure virtual networks, supporting secure and scalable name resolution for private endpoints and hybrid connectivity scenarios.

## Components and resources

The module provisions the following Azure resources:
* Resource group for DNS resources
* Private DNS Resolver instance
* Inbound and outbound endpoints for DNS traffic
* DNS forwarding ruleset
* DNS forwarding rules
* Virtual network links to associate the resolver with one or more virtual networks

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "private_dns_resolver" {
  source                        = "path_to_this_module"
  environment                   = "dev"
  workload                      = "my-workload"
  location                      = "westeurope"
  location_abbreviation         = "weu"
  virtual_network_id            = "your-virtual-network-id"
  dns_inbound_pe_subnet_id      = "your-inbound-endpoint-subnet-id"
  dns_outbound_pe_subnet_id     = "your-outbound-endpoint-subnet-id"
  virtual_network_ids           = {
    "vnet1" = "vnet1-id"
    "vnet2" = "vnet2-id"
  }
  dns_forwarding_rules = {
    "example.com" = ["8.8.8.8", "8.8.4.4"]
  }
  tags = {
    "Environment" = "dev"
    "Owner"     = "team"
  }
}
```

or

```hcl
module "idty_private_dns_resolver" {
  source  = "../../_modules/private_dns_resolver"

  workload                  = "identity"
  environment               = var.environment
  location                  = var.location
  location_abbreviation     = var.location_abbreviation
  virtual_network_id        = module.idty_virtual_network.virtual_network_id
  dns_inbound_pe_subnet_id  = module.idty_virtual_network.subnet_id["snet-dnsie-prod-001"]
  dns_outbound_pe_subnet_id = module.idty_virtual_network.subnet_id["snet-dnsoe-prod-001"]
  dns_forwarding_rules      = var.dns_forwarding_rules
  virtual_network_ids = {
    "connectivity" = module.cnty_virtual_network.virtual_network_id,
    "management"   = module.mgmt_virtual_network.virtual_network_id,
    "identity"   = module.idty_virtual_network.virtual_network_id,
    "connected"  = module.conn_virtual_network.virtual_network_id
  }
  tags = local.tags
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_resolver.dnspr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.dnsfrs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset) | resource |
| [azurerm_private_dns_resolver_forwarding_rule.dnsfr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |
| [azurerm_private_dns_resolver_virtual_network_link.dnspr_vnl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link) | resource |
| [azurerm_resource_group.rg_dnspr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_forwarding_rules"></a> [dns\_forwarding\_rules](#input\_dns\_forwarding\_rules) | (Optional) List of domain names and DNS servers IP addresses for DNS resolver rules<br/>    Example: <br/>    dns\_forwarding\_rules = {<br/>        "onprem.local." = ["192.168.1.1"],<br/>        "corp.com."     = ["10.10.0.1", "10.10.0.2"]<br/>        } | `map(list(string))` | `{}` | no |
| <a name="input_dns_inbound_pe_subnet_id"></a> [dns\_inbound\_pe\_subnet\_id](#input\_dns\_inbound\_pe\_subnet\_id) | (Required) The ID of the DNS Inbound Private Endpoint Subnet. | `string` | n/a | yes |
| <a name="input_dns_outbound_pe_subnet_id"></a> [dns\_outbound\_pe\_subnet\_id](#input\_dns\_outbound\_pe\_subnet\_id) | (Required) The ID of the DNS Outbound Private Endpoint Subnet. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | (Required) The ID of the Virtual Network used for DNS resolver creation. | `string` | n/a | yes |
| <a name="input_virtual_network_ids"></a> [virtual\_network\_ids](#input\_virtual\_network\_ids) | (Optional) Map of Virtual Network IDs to be used in DNS Resolver Virtual network links<br/>    Example:<br/>      virtual\_network\_ids = {<br/>          "vnet1" = "/subscriptions/.../virtualNetworks/vnet1",<br/>          "vnet2" = "/subscriptions/.../virtualNetworks/vnet2"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_resource_group"></a> [dns\_resource\_group](#output\_dns\_resource\_group) | The name of the Resource Group. |
<!-- END_TF_DOCS -->