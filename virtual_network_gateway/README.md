# Virtual Network Gateway Module

## Overview

This module deploys and manages an Azure Virtual Network Gateway using Terraform. It provisions all necessary resources to enable secure site-to-site VPN connectivity between your Azure virtual network and on-premises networks.

## Components and resources

The module provisions the following Azure resources:
* Public IP address for the Virtual Network Gateway
* Azure Virtual Network Gateway
* Diagnostic settings of Virtual Network Gateway for monitoring
* Local Network Gateway (representing the on-premises VPN device)
* Virtual Network Gateway Connection (for VPN connectivity)

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "virtual_network_gateway" {
  source                                = "path_to_this_module"
  
  environment                           = "dev"
  workload                              = "my-workload"
  location                              = "westeurope"
  location_abbreviation                 = "weu"
  resource_group_name                   = "your-resource-group"
  virtual_network_name                  = "your-virtual-network"
  virtual_network_gateway_subnet_id     = "your-subnet-id"
  local_network_gateway_ip_address      = "on-prem-public-ip"
  local_network_gateway_address_space   = ["10.0.0.0/24"]
  shared_key                            = "your-shared-key"
  log_analytics_workspace_id            = "your-log-analytics-workspace-id"
  tags = {
    Environment = "dev"
    Owner     = "team"
  }
}
```

or

```hcl
module "cnty_virtual_network_gateway" {
  source  = "../../_modules/virtual_network_gateway"

  workload              = "connectivity"
  environment             = var.environment
  location              = var.location
  location_abbreviation         = var.location_abbreviation
  resource_group_name         = module.cnty_virtual_network.resource_group_name
  virtual_network_name        = module.cnty_virtual_network.virtual_network_name
  virtual_network_gateway_subnet_id   = module.cnty_virtual_network.subnet_id["GatewaySubnet"]
  log_analytics_workspace_id      = module.mgmt_monitor.log_analytics_workspace_id
  local_network_gateway_ip_address  = var.local_network_gateway_ip_address
  local_network_gateway_address_space = var.local_network_gateway_address_space
  shared_key              = var.lgw_shared_key
  tags                = local.tags
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
| [azurerm_local_network_gateway.lgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting_vgw_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.pip_virtual_network_gateway_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_network_gateway.vgw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.vgw_connection_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_local_network_gateway_address_space"></a> [local\_network\_gateway\_address\_space](#input\_local\_network\_gateway\_address\_space) | (Required) The address space of the Local Network Gateway (On-premisses network address space).<br/>    Example:<br/>      local\_network\_gateway\_address\_space = [<br/>        "172.16.0.0/24",<br/>        "192.168.0.0/24"<br/>      ] | `list(string)` | n/a | yes |
| <a name="input_local_network_gateway_ip_address"></a> [local\_network\_gateway\_ip\_address](#input\_local\_network\_gateway\_ip\_address) | (Required) The IP address of the Local Network Gateway (Public IP address of On-premisses network device). | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) The Log Analytics Workspace ID of Management subscription. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group for Firewall. | `string` | n/a | yes |
| <a name="input_shared_key"></a> [shared\_key](#input\_shared\_key) | (Required) The shared key for the VPN gateway connection. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_virtual_network_gateway_subnet_id"></a> [virtual\_network\_gateway\_subnet\_id](#input\_virtual\_network\_gateway\_subnet\_id) | (Required) The ID of the Azure Virtual Network Gateway Subnet. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_network_gateway_id"></a> [virtual\_network\_gateway\_id](#output\_virtual\_network\_gateway\_id) | The ID of the Azure Virtual Network Gateway. |
| <a name="output_virtual_network_gateway_public_ip_address"></a> [virtual\_network\_gateway\_public\_ip\_address](#output\_virtual\_network\_gateway\_public\_ip\_address) | The public IP address of the Azure Virtual Network Gateway. |
<!-- END_TF_DOCS -->