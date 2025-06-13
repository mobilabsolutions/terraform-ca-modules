# Update Management Module

## Overview

This module deploys and manages Azure Update Management configurations using Terraform. It provisions the necessary resources to automate patching and maintenance for both Linux and Windows virtual machines across different environments, supporting compliance and operational efficiency.

## Components and resources

The module provisions the following Azure resources:
* Resource group for update management resources
* Maintenance configurations for production and non-production environments
* Dynamic scope assignments for targeted update management based on Environment Tags

All resources are parameterized for consistent and repeatable deployments across Azure environments

## Usage

```hcl
module "update_management" {
  source                                = "path_to_this_module"

  environment                           = "dev"
  workload                              = "my-workload"
  location                              = "westeurope"
  location_abbreviation                 = "weu"
  environments_list                     = ["dev", "prod"]
  linux_classifications_to_include      = ["Critical", "Security"]
  windows_classifications_to_include    = ["CriticalUpdates", "SecurityUpdates"]
  start_time                            = "2025-06-02 23:00"
  time_zone                             = "Central European Standard Time"
  tags = {
    "Environment" = "dev"
    "Owner"       = "team"
  }
}
```

or

```hcl
module "mgmt_update_management" {
  source                             = "../../_modules/update_management"

  environment                        = var.environment
  workload                           = "management"
  location                           = var.location
  location_abbreviation              = var.location_abbreviation
  tags                               = local.tags
  time_zone                          = var.time_zone
  environments_list                  = local.allowed_tags_list["Environment"]
  start_time                         = var.mgmt_maintenance_start_time
  windows_classifications_to_include = ["Critical", "Security"]
  linux_classifications_to_include   = ["Critical", "Security"]
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
| [azurerm_maintenance_assignment_dynamic_scope.mc_dynamic_scope](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_assignment_dynamic_scope) | resource |
| [azurerm_maintenance_configuration.mc_non_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_configuration) | resource |
| [azurerm_maintenance_configuration.mc_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/maintenance_configuration) | resource |
| [azurerm_resource_group.rg_update_management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_environments_list"></a> [environments\_list](#input\_environments\_list) | (Required) A list of environments to create dynamic scopes for.<br/>    Example:<br/>      environments\_list = [<br/>        "Dev",<br/>        "Test",<br/>        "Prod"<br/>      ] | `set(string)` | n/a | yes |
| <a name="input_linux_classifications_to_include"></a> [linux\_classifications\_to\_include](#input\_linux\_classifications\_to\_include) | (Required) The Linux classifications to include.<br/>    Example:<br/>      linux\_classifications\_to\_include = [<br/>        "Critical",<br/>        "Security"<br/>      ] | `list(string)` | n/a | yes |
| <a name="input_linux_package_names_mask_to_exclude"></a> [linux\_package\_names\_mask\_to\_exclude](#input\_linux\_package\_names\_mask\_to\_exclude) | (Optional) The Linux package names mask to exclude.<br/>    Example:<br/>      linux\_package\_names\_mask\_to\_exclude = [<br/>        "package1",<br/>        "package2"<br/>      ] | `list(string)` | `[]` | no |
| <a name="input_linux_package_names_mask_to_include"></a> [linux\_package\_names\_mask\_to\_include](#input\_linux\_package\_names\_mask\_to\_include) | (Optional) The Linux package names mask to include.<br/>    Example:<br/>      linux\_package\_names\_mask\_to\_include = [<br/>        "package1",<br/>        "package2"<br/>      ] | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_start_time"></a> [start\_time](#input\_start\_time) | (Required) The start time for the maintenance configuration.<br/>    It should be in the format 'YYYY-MM-DD HH:MM'.<br/>    Example: <br/>      start\_time = '2025-06-02 23:00'. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_time_zone"></a> [time\_zone](#input\_time\_zone) | (Required) Specifies the timezone. | `string` | n/a | yes |
| <a name="input_windows_classifications_to_include"></a> [windows\_classifications\_to\_include](#input\_windows\_classifications\_to\_include) | (Required) The Windows classifications to include.<br/>    Example:<br/>      windows\_classifications\_to\_include = [<br/>        "Critical",<br/>        "Security"<br/>        ] | `list(string)` | n/a | yes |
| <a name="input_windows_kb_numbers_to_exclude"></a> [windows\_kb\_numbers\_to\_exclude](#input\_windows\_kb\_numbers\_to\_exclude) | (Optional) The Windows KB numbers to exclude.<br/>    Example:<br/>      windows\_kb\_numbers\_to\_exclude = [<br/>        "KB1234567",<br/>        "KB7654321"<br/>      ] | `list(string)` | `[]` | no |
| <a name="input_windows_kb_numbers_to_include"></a> [windows\_kb\_numbers\_to\_include](#input\_windows\_kb\_numbers\_to\_include) | (Optional) The Windows KB numbers to include.<br/>    Example:<br/>      windows\_kb\_numbers\_to\_include = [<br/>        "KB1234567",<br/>        "KB7654321"<br/>      ] | `list(string)` | `[]` | no |
| <a name="input_workload"></a> [workload](#input\_workload) | (Required) The workload or subcription name for the Azure resources names composition. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->