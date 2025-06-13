# Policies Module

## Overview

This module deploys and manages Azure Policy resources, including custom policy definitions and policy set (initiative) assignments at the management group level. It enforces organizational standards for resource tagging and compliance across your Azure environment.

## Components and resources

The module provisions the following Azure resources:
* Custom Policy Definitions to require specific tags on resource groups (e.g., Business Criticality, Data Confidentiality, Environment)
* Policy Set Definitions (initiatives) to group related policies for streamlined assignment
* Policy Assignments at both top-level and landing zone management groups to enforce compliance

All resources are parameterized to support consistent and repeatable deployments across different Azure environments.

## Usage

```hcl
module "policies" {
  source                             = "path_to_this_module"

  allowed_tags = {
    "Business Criticality"           = ["Low", "Medium", "High", "Critical"]
    "Data Confidentiality"           = ["Public", "Internal", "Internal-Confidential", "Restricted"]
    "Environment"                    = ["prd", "tst", "dev"]
  }
  landing_zone_management_group_id   = "your-landing-zone-mg-id"
  location                           = "westeurope"
  policy_assignment_enforcement_mode = "Default"
  top_management_group_id            = "your-top-mg-id"
}
}
```

or

```hcl
module "mgmt_policies" {
  source                             = "../../_modules/policies"

  allowed_tags = {
    "Business Criticality" = [
      "Low",
      "Medium",
      "High",
      "Critical"
    ],
    "Data Confidentiality" = [
      "Public",
      "Internal",
      "Internal-Confidential",
      "Restricted"
    ],
    "Environment" = [
      "prd",
      "tst",
      "dev"
    ]
  }
  landing_zone_management_group_id   = var.landing_zone_management_group_id
  location                           = var.location
  policy_assignment_enforcement_mode = true
  top_management_group_id            = var.top_management_group_id
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
| [azurerm_management_group_policy_assignment.landing_zones_policy_initiative_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_management_group_policy_assignment.main_policy_initiative_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment) | resource |
| [azurerm_policy_definition.require_tag_on_resource_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_policy_set_definition.connected_mg_initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |
| [azurerm_policy_set_definition.main_mg_mobilab_initiative](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_tags"></a> [allowed\_tags](#input\_allowed\_tags) | "(Required) List of allowed tags for Custom Policy Definitions of Required Tags on RG for Business Criticality, Data Confidentiality and Environment."<br/><br/>  Example structure:<br/>  {<br/>    "Data Confidentiality" = ["Public", "Internal", "Internal-Confidential", "Restricted"],<br/>    "Environment"          = ["prd", "tst", "dev"],<br/>    "Business Criticality" = ["Low", "Medium", "High", "Critical"]<br/>  } | `map(list(string))` | n/a | yes |
| <a name="input_landing_zone_management_group_id"></a> [landing\_zone\_management\_group\_id](#input\_landing\_zone\_management\_group\_id) | (Required) Landing Zones Management group ID used for the Policy Assigment. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `any` | n/a | yes |
| <a name="input_policy_assignment_enforcement_mode"></a> [policy\_assignment\_enforcement\_mode](#input\_policy\_assignment\_enforcement\_mode) | (Required) Specifies the enforcement mode for the policy assignment. | `string` | n/a | yes |
| <a name="input_top_management_group_id"></a> [top\_management\_group\_id](#input\_top\_management\_group\_id) | (Required) Top level Management group ID used for the Policy Assigment. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->