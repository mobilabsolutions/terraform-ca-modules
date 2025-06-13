# Application Gateway module

## Overview

This module provisions an Azure Application Gateway along with associated resources such as a public IP address and diagnostic settings. It enables secure and scalable web traffic management for your applications, supporting features like SSL termination, URL-based routing, and Web Application Firewall (WAF) integration. The module is parameterized for environment, location, and workload, ensuring consistent and flexible deployments across Azure environments.

## Components and resources

The module provisions the following Azure resources:
* Application Gateway resource
* Public IP address for frontend connectivity
* Diagnostic settings for monitoring and logging

This setup enables secure, highly available, and observable application delivery, with monitoring data sent to Log Analytics for operational insights. All resources are configurable to fit different environments and workloads.

## Usage

```hcl
module "application_gateway" {
  source                     = "path_to_this_module"
  
  environment                = "prod"
  location                   = "westeurope"
  location_abbreviation      = "weu"
  workload                   = "myapp"
  resource_group_name        = "rg-myapp-prod-weu"
  virtual_network_name       = "vnet-myapp-prod-weu"
  application_gateway_subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-myapp-prod-weu/providers/Microsoft.Network/virtualNetworks/vnet-myapp-prod-weu/subnets/agw-subnet"
  log_analytics_workspace_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-logs/providers/Microsoft.OperationalInsights/workspaces/logs-weu"
  tags = {
    environment = "prod"
    owner       = "devops"
  }
}
```

or

```hcl
module "cnty_application_gateway" {
  source    = "../../_modules/application_gateway"

  workload                      = "connectivity"
  environment                   = var.environment
  location                      = var.location
  location_abbreviation         = var.location_abbreviation
  resource_group_name           = module.cnty_virtual_network.resource_group_name
  virtual_network_name          = module.cnty_virtual_network.virtual_network_name
  application_gateway_subnet_id = module.cnty_virtual_network.subnet_id["ApplicationGatewaySubnet"]
  log_analytics_workspace_id    = module.mgmt_monitor.log_analytics_workspace_id
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
| [azurerm_application_gateway.application_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting_application_gateway_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.pip_application_gateway_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_gateway_subnet_id"></a> [application\_gateway\_subnet\_id](#input\_application\_gateway\_subnet\_id) | (Required) The ID of the Application Gateway Subnet. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) The Log Analytics Workspace ID of Management subscription. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group for Application Gateway. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | (Required) The Name of the Virtual Network where the Bastion should be created. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_gateway_id"></a> [application\_gateway\_id](#output\_application\_gateway\_id) | The ID of the Azure Application Gateway. |
| <a name="output_application_gateway_public_ip_address"></a> [application\_gateway\_public\_ip\_address](#output\_application\_gateway\_public\_ip\_address) | The public IP address of the Azure Application Gateway. |
<!-- END_TF_DOCS -->