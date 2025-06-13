# Backup module

## Overview

This module deploys and configures Azure Recovery Services Vaults and backup policies for Virtual Machines, SQL workloads, and File Shares. It also sets up diagnostic settings for monitoring and integrates with Log Analytics for centralized logging. The module enables automated backup management and monitoring, supporting robust data protection and compliance in Azure environments.

## Components and resources

The module provisions the following Azure resources:
* Resource groups for backup recovery service vaults and snapshots
* Recovery Services Vaults with Geo-Redundant Storage (GRS) and Locally Redundant Storage (LRS)
* Backup policies for VMs, SQL workloads, and File Shares (with high, medium, and low tiers)
* Diagnostic settings for Recovery Services Vaults, forwarding logs to Log Analytics

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "backup" {
  source                        = "path_to_this_module"
  
  environment                   = "prod"
  location                      = "westeurope"
  location_abbreviation         = "weu"
  workload                      = "myapp"
  log_analytics_workspace_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-logs/providers/Microsoft.OperationalInsights/workspaces/logs-weu"
  timezone                      = "W. Europe Standard Time"
  tags = {
    environment = "prod"
    owner       = "devops"
  }
}
```

or

```hcl
module "cnty_backup" {
  source    = "../../_modules/backup"

  workload                   = "connectivity"
  environment                = var.environment
  location                   = var.location
  location_abbreviation      = var.location_abbreviation
  timezone                   = var.time_zone
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
| [azurerm_backup_policy_file_share.backup_policy_file_share_high_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share) | resource |
| [azurerm_backup_policy_vm.backup_policy_vm_high_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_backup_policy_vm.backup_policy_vm_low_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_backup_policy_vm.backup_policy_vm_medium_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm) | resource |
| [azurerm_backup_policy_vm_workload.backup_policy_sql_high_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm_workload) | resource |
| [azurerm_backup_policy_vm_workload.backup_policy_sql_low_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm_workload) | resource |
| [azurerm_backup_policy_vm_workload.backup_policy_sql_medium_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_vm_workload) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting_grs_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostic_setting_lrs_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_recovery_services_vault.grs_vault_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_recovery_services_vault.lrs_vault_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_resource_group.rg_backup_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.rg_backup_snapshots_001](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | (Required) The Log Analytics Workspace ID of Management subscription to store Diagnostic settings of Recovery Service Vaults. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | (Required) Specifies the timezone. | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grs_vault_001_id"></a> [grs\_vault\_001\_id](#output\_grs\_vault\_001\_id) | value of the GRS Recovery Services Vault ID |
| <a name="output_grs_vault_001_name"></a> [grs\_vault\_001\_name](#output\_grs\_vault\_001\_name) | value of the GRS Recovery Services Vault Name |
| <a name="output_lrs_vault_001_id"></a> [lrs\_vault\_001\_id](#output\_lrs\_vault\_001\_id) | value of the LRS Recovery Services Vault ID |
| <a name="output_lrs_vault_001_name"></a> [lrs\_vault\_001\_name](#output\_lrs\_vault\_001\_name) | value of the LRS Recovery Services Vault Name |
<!-- END_TF_DOCS -->