# Virtual Network Module

## Overview

This module deploys and manages Azure Virtual Network resources using Terraform. It provisions a virtual network, subnets, and related resources, supporting secure and scalable network segmentation for your Azure workloads.

## Components and resources

The module provisions the following Azure resources:
* Resource group for network resources
* Virtual network (VNet)
* One or more subnets within the VNet
* Optional subnet delegations for specific Azure services

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "virtual_network" {
  source                        = "path_to_this_module"
    
  environment                   = "dev"
  workload                      = "my-workload"
  location                      = "westeurope"
  location_abbreviation         = "weu"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_prefixes = {
    "subnet1" = "10.0.1.0/24"
    "subnet2" = "10.0.2.0/24"
  }
  subnet_delegations = {
    "subnet1" = [{
        name = "Microsoft.Network.dnsResolvers"
        service_delegation = {
            name    = "Microsoft.Network/dnsResolvers"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
    }]
  }
  tags = {
    "Environment" = "dev"
    "Owner"       = "team"
  }
}
```

or

```hcl
module "cnty_virtual_network" {
  source                        = "../../_modules/virtual_network"

  workload                      = "connectivity-aleksei"
  environment                   = var.environment
  location                      = var.location
  location_abbreviation         = var.location_abbreviation
  virtual_network_address_space = var.cnty_virtual_network_address_space
  subnet_prefixes               = var.cnty_subnet_prefixes
  tags                          = local.tags
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
| [azurerm_resource_group.rg_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_subnet_delegations"></a> [subnet\_delegations](#input\_subnet\_delegations) | (Optional) Some subnets require Delegations, for instance, subnets of DNS resolver private endpoints<br/>  in the DNS zone. This variable allows you to define those delegations.<br/>  Example:<br/>    subnet\_delegations = {<br/>      snet-dnsie-prod-001 = [{<br/>        name = "Microsoft.Network.dnsResolvers"<br/>        service\_delegation = {<br/>          name    = "Microsoft.Network/dnsResolvers"<br/>          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]<br/>          }<br/>        }]<br/>      snet-dnsoe-prod-001 = [{<br/>        name = "Microsoft.Network.dnsResolvers"<br/>      service\_delegation = {<br/>        name    = "Microsoft.Network/dnsResolvers"<br/>        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]<br/>        }<br/>      }]<br/>    } | <pre>map(list(object({<br/>    name = string<br/>    service_delegation = object({<br/>      name    = string<br/>      actions = list(string)<br/>    })<br/>  })))</pre> | `{}` | no |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes) | (Required) The IP address ranges for Subnets of the Virtual Network. | `map(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | (Required) The IP address space for the Virtual Network. | `list(string)` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | The location/region of the Resource Group for Network. |
| <a name="output_location_abbreviation"></a> [location\_abbreviation](#output\_location\_abbreviation) | The abbreviation for the location of the Azure resources. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The name of the Resource Group for Network. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group for Network. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The IDs of the Azure Subnets. |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The ID of the Azure Virtual Network. |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the Azure Virtual Network. |
<!-- END_TF_DOCS -->