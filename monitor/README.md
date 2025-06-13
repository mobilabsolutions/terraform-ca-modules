# Monitor module

## Overview

This module deploys and configures Azure Monitor resources, including Log Analytics Workspace and Data Collection Rules for both Linux and Windows. It enables centralized monitoring, logging, and diagnostics for your Azure environment, supporting integration with other Azure services.

## Components and resources

The module provisions the following Azure resources:
* Resource Group for organizing monitoring resources
* Log Analytics Workspace for collecting and analyzing logs
* time_sleep resource to ensure Log Analytics Workspace tables are ready before proceeding
* Data Collection Rules for Linux and Windows to manage data ingestion

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "monitor" {
  source                  = "path_to_this_module"
  environment             = "prod"
  location                = "westeurope"
  location_abbreviation   = "weu"
  workload                = "myapp"
  tags = {
    environment = "prod"
    owner       = "devops"
  }
}
```

or

```hcl
module "mgmt_monitor" {
  source                  = "../../_modules/monitor"

  workload                = "management"
  environment             = var.environment
  location                = var.location
  location_abbreviation   = var.location_abbreviation
  tags                    = local.tags
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
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.log_monitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_data_collection_rule.dcr_linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |
| [azurerm_monitor_data_collection_rule.dcr_windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule) | resource |
| [azurerm_resource_group.rg_monitor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [time_sleep.wait_for_log_analytics_workspace_tables_are_ready](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_data_collection_rule_id"></a> [linux\_data\_collection\_rule\_id](#output\_linux\_data\_collection\_rule\_id) | The ID of the Data Collection Rule for Linux. This will be used to associate with the Linux Virtual Machine. |
| <a name="output_location"></a> [location](#output\_location) | The location/region of the Resource Group for Network. |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | The ID of the Log Analytics Workspace. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group for Network. |
| <a name="output_windows_data_collection_rule_id"></a> [windows\_data\_collection\_rule\_id](#output\_windows\_data\_collection\_rule\_id) | The ID of the Data Collection Rule for Windows. This will be used to associate with the Windows Virtual Machine. |
<!-- END_TF_DOCS -->