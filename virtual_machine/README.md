# Virtual Machine Module

## Overview

This module deploys and manages Azure Virtual Machines using Terraform. It provisions all necessary resources for running Linux or Windows VMs, including network interfaces, public IPs (optional), and monitoring extensions. The module is parameterized for flexible and repeatable deployments across different Azure environments.

## Components and resources

The module provisions the following Azure resources:
* Azure Virtual Machine (Linux or Windows)
* Network Interface
* Public IP (optional)
* OS disk with configurable storage type
* Data Collection Rule Association for monitoring
* VM extensions for monitoring agents

All resources are parameterized to support consistent deployments in various environments.

## Usage

```hcl
module "virtual_machine" {
    source                       = "path_to_this_module"

    environment                  = "dev"
    location                     = "westeurope"
    location_abbreviation        = "weu"
    resource_group_name          = "my-rg"
    subnet_id                    = "your-subnet-id"
    vm_name                      = "my-vm"
    vm_size                      = "Standard_DS1_v2"
    os_type                      = "Linux"
    admin_username               = "azureuser"
    admin_password               = "your-password"
    os_image_publisher           = "Canonical"
    os_image_offer               = "UbuntuServer"
    os_image_sku                 = "18.04-LTS"
    os_image_version             = "latest"
    os_disk_storage_account_type = "Standard_LRS"
    private_ip_address           = "10.0.0.4"
    public_ip_enable             = false
    data_collection_rule_id      = "your-data-collection-rule-id"
    tags = {
        "Environment" = "dev"
        "Owner"       = "team"
    }
}
```

or

```hcl
module "virtual_machine_windows_001" {
  source                       = "../../_modules/virtual_machine"

  os_type                      = "Windows"
  vm_name                      = "vmtest01"
  resource_group_name          = module.rsch_virtual_network.resource_group_name
  location                     = module.rsch_virtual_network.location
  location_abbreviation        = module.rsch_virtual_network.location_abbreviation
  environment                  = var.environment
  subnet_id                    = module.rsch_virtual_network.subnet_id["snet-example-prod-001"]
  vm_size                      = "Standard_D2s_v3"
  admin_username               = "adminuser"
  admin_password               = "P@ssw0rd1234!"
  private_ip_address           = "10.10.20.36"
  public_ip_enable             = true
  data_collection_rule_id      = module.rsch_monitor.windows_data_collection_rule_id
  tags                         = local.tags
  os_disk_storage_account_type = "Standard_LRS"
  os_image_publisher           = "MicrosoftWindowsServer"
  os_image_offer               = "WindowsServer"
  os_image_sku                 = "2022-Datacenter"
  os_image_version             = "latest"
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
| [azurerm_linux_virtual_machine.linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_monitor_data_collection_rule_association.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |
| [azurerm_monitor_data_collection_rule_association.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_data_collection_rule_association) | resource |
| [azurerm_network_interface.vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.vm_pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_virtual_machine_extension.linux_vm_ama_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.windows_vm_ama_extension](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | (Required) The administrator password for the Azure Virtual Machine. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The administrator username for the Azure Virtual Machine. | `string` | n/a | yes |
| <a name="input_data_collection_rule_id"></a> [data\_collection\_rule\_id](#input\_data\_collection\_rule\_id) | (Required) The ID of the data collection rule to associate with the Azure Virtual Machine. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The environment name for the Azure resources names composition. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_location_abbreviation"></a> [location\_abbreviation](#input\_location\_abbreviation) | (Required) The abbreviation for the location of the Azure resources. | `string` | n/a | yes |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | (Required) The storage account type for the OS disk, e.g., Standard\_LRS or Premium\_LRS. | `string` | n/a | yes |
| <a name="input_os_image_offer"></a> [os\_image\_offer](#input\_os\_image\_offer) | (Required) The offer of the OS image, e.g., UbuntuServer for Linux or WindowsServer for Windows. | `string` | n/a | yes |
| <a name="input_os_image_publisher"></a> [os\_image\_publisher](#input\_os\_image\_publisher) | (Required) The publisher of the OS image, e.g., Canonical for Linux or MicrosoftWindowsServer for Windows. | `string` | n/a | yes |
| <a name="input_os_image_sku"></a> [os\_image\_sku](#input\_os\_image\_sku) | (Required) The SKU of the OS image, e.g., 18.04-LTS for Linux or 2019-Datacenter for Windows. | `string` | n/a | yes |
| <a name="input_os_image_version"></a> [os\_image\_version](#input\_os\_image\_version) | (Required) The version of the OS image, e.g., latest for the latest version. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) The type of the operating system for the Azure Virtual Machine, e.g., Linux or Windows. | `string` | n/a | yes |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | (Required) The private IP address to assign to the Azure Virtual Machine. If not specified, Azure will assign one automatically. | `string` | n/a | yes |
| <a name="input_public_ip_enable"></a> [public\_ip\_enable](#input\_public\_ip\_enable) | (Optional) Whether to enable a public IP address for the Azure Virtual Machine. Defaults to false. | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group where the Azure Virtual Machine will be created. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Required) The ID of the subnet where the Azure Virtual Machine will be deployed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resources.<br/>    Example:<br/>      tags = {<br/>          Environment = "Dev",<br/>          Owner       = "Owner.Name"<br/>      } | `map(string)` | `{}` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) The name of the Azure Virtual Machine. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) The size of the Azure Virtual Machine, e.g., Standard\_DS1\_v2. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address of the virtual machine. |
<!-- END_TF_DOCS -->