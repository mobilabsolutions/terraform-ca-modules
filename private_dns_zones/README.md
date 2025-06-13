# Private DNS Zones Module

## Overview

This module deploys and manages Azure Private DNS Zones using Terraform. It provisions the necessary components to enable private DNS resolution within your Azure virtual networks, supporting secure and scalable name resolution for private endpoints and internal resources.

## Components and resources

The module provisions the following Azure resources:
* Resource group for DNS resources
* One or more Azure Private DNS Zones
* Virtual network links to associate each DNS zone with a virtual network

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "private_dns_zones" {
  source                = "path_to_this_module"
  
  environment           = "dev"
  workload              = "my-workload"
  location              = "westeurope"
  location_abbreviation = "weu"
  virtual_network_id    = "your-virtual-network-id"
  private_dns_zones     = [
    "privatelink.database.windows.net",
    "privatelink.blob.core.windows.net"
  ]
  tags = {
    "Environment" = "dev"
    "Owner"     = "team"
  }
}
```

or

```hcl
module "idty_private_dns_zones" {
  source  = "../../_modules/private_dns_zones"

  workload              = "identity"
  environment           = var.environment
  location              = var.location
  location_abbreviation = var.location_abbreviation
  virtual_network_id    = module.idty_virtual_network.virtual_network_id
  private_dns_zones     = var.private_dns_zones
  tags                  = local.tags
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
| [azurerm_private_dns_zone.pr_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.dns_zone_vnet_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.rg_dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones) | (Required) List of private DNS zones to be created.<br/>    Example:<br/>      private\_dns\_zones = [<br/>        "privatelink.database.windows.net",<br/>        "privatelink.servicebus.windows.net"<br/>      ] | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | (Required) The ID of the Virtual Network. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_resource_group"></a> [dns\_resource\_group](#output\_dns\_resource\_group) | The name of the Resource Group. |
<!-- END_TF_DOCS -->