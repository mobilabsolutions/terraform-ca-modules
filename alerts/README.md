# Alerts module

## Overview

This module deploys Azure Monitor alerts for Virtual Machines performance monitoring of metrics such as CPU Utilization, Memory consumption, Disk space usage, and Backup job status. 
This module helps you quickly receive notifications and better monitor the health of your infrastructure in Azure.

## Components and resources
The module provisions the following Azure resources:
 * Resource group
 * Action group for notifications
 * VM CPU Utilization High scheduled query rule alert
 * VM CPU Utilization Critical scheduled query rule alert
 * VM Memory Utilization High scheduled query rule alert
 * VM Memory Utilization Critical scheduled query rule alert
 * VM Disk space usage High scheduled query rule alert
 * VM Disk space usage Critical scheduled query rule alert
 * Failed Backup jobs scheduled query rule alert

When thresholds are breached, notifications are sent to the defined email receivers via the action group, enabling rapid response to operational issues. All resources are parameterized for environment, location, and workload, supporting flexible and consistent deployments across Azure environments.

## Usage

```hcl
module "alerts" {
  source                        = "path_to_this_module"
  environment                   = "prod"
  location                      = "westeurope"
  location_abbreviation         = "weu"
  workload                      = "myapp"
  subscription_id               = "00000000-0000-0000-0000-000000000000"
  log_analytics_workspace_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-logs/providers/Microsoft.OperationalInsights/workspaces/logs-weu"
  email_receivers = {
    "operations" = "ops@example.com"
    "devops"     = "devops@example.com"
    }
  tags = {
    environment = "prod"
    owner       = "devops"
  }
}
```
or
```hcl
module "mgmt_alerts" {
  source = "../../_modules/alerts"

  environment                = var.environment
  workload                   = "management"
  location                   = var.location
  location_abbreviation      = var.location_abbreviation
  tags                       = local.tags
  email_receivers            = var.action_group_email_receivers
  subscription_id            = data.azurerm_client_config.management.subscription_id
  log_analytics_workspace_id = module.mgmt_monitor.log_analytics_workspace_id
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
| [azurerm_monitor_action_group.ag-operations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.failed_backup_jobs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.vm_cpu_utilization_critical](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.vm_cpu_utilization_high](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.vm_disk_space_critical](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.vm_disk_space_high](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.vm_memory_utilization_critical](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_monitor_scheduled_query_rules_alert_v2.vm_memory_utilization_high](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert_v2) | resource |
| [azurerm_resource_group.rg_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_receivers"></a> [email\_receivers](#input\_email\_receivers) | (Required) A list of email receivers for the action group.<br/>    Example: <br/>      action\_group\_email\_receivers = {<br/>          support = "support.team@example.com",<br/>          internal = "user2@gmail.com"<br/>      } | `map(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) The Log Analitycs Workspace ID for the Azure resources. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | (Required) The subscription ID for the Azure resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | The location/region of the Resource Group for Network. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the Resource Group for Network. |
<!-- END_TF_DOCS -->