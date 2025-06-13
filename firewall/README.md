# Firewall module

## Overview

This module deploys and configures an Azure Firewall, including all required resources such as public IP, subnet association, and diagnostic settings. It integrates with Log Analytics for centralized monitoring and logging. The module enables secure and controlled network traffic filtering for your Azure environment.

## Components and resources

The module provisions the following Azure resources:
* Azure Firewall in a specified subnet within a virtual network
* Public IP address for the Firewall
* Diagnostic settings for the Firewall, forwarding logs to Log Analytics

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "firewall" {
  source                      = "path_to_this_module"
  environment                 = "prod"
  location                    = "westeurope"
  location_abbreviation       = "weu"
  workload                    = "myapp"
  resource_group_name         = "rg-prod-weu"
  virtual_network_name        = "vnet-prod-weu"
  firewall_subnet_id          = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-prod-weu/providers/Microsoft.Network/virtualNetworks/vnet-prod-weu/subnets/AzureFirewallSubnet"
  log_analytics_workspace_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-logs/providers/Microsoft.OperationalInsights/workspaces/logs-weu"
  tags = {
    environment = "prod"
    owner       = "devops"
  }
}
```

or

```hcl
module "cnty_firewall" {
  source     = "../../_modules/firewall"

  workload                   = "connectivity"
  environment                = var.environment
  location                   = var.location
  location_abbreviation      = var.location_abbreviation
  resource_group_name        = module.cnty_virtual_network.resource_group_name
  virtual_network_name       = module.cnty_virtual_network.virtual_network_name
  firewall_subnet_id         = module.cnty_virtual_network.subnet_id["AzureFirewallSubnet"]
  log_analytics_workspace_id = module.mgmt_monitor.log_analytics_workspace_id
  tags                       = local.tags
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
| [azurerm_firewall.firewall](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting_firewall_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_public_ip.pip_firewall_01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_firewall_subnet_id"></a> [firewall\_subnet\_id](#input\_firewall\_subnet\_id) | (Required) The ID of the Azure Firewall Subnet. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) The Log Analytics Workspace ID of Management subscription. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group for Firewall. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | The ID of the Azure Firewall. |
| <a name="output_firewall_private_ip"></a> [firewall\_private\_ip](#output\_firewall\_private\_ip) | The private IP address of the Azure Firewall. |
| <a name="output_firewall_public_ip_address"></a> [firewall\_public\_ip\_address](#output\_firewall\_public\_ip\_address) | The public IP address of the Azure Firewall. |
<!-- END_TF_DOCS -->