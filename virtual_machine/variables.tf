variable "environment" {
  description = "(Required) The environment name for the Azure resources names composition."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resources exist."
  type        = string
}

variable "location_abbreviation" {
  description = "(Required) The abbreviation for the location of the Azure resources."
  type        = string
}

variable "tags" {
  description = <<EOF
    (Optional) A mapping of tags to assign to the resources.
    Example:
      tags = {
          Environment = "Dev",
          Owner       = "Owner.Name"
      }
  EOF
  type        = map(string)

  default = {}
}

variable "vm_name" {
  description = "(Required) The name of the Azure Virtual Machine."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where the Azure Virtual Machine will be created."
  type        = string
}

variable "vm_size" {
  description = "(Required) The size of the Azure Virtual Machine, e.g., Standard_DS1_v2."
  type        = string
}

variable "admin_username" {
  description = "(Required) The administrator username for the Azure Virtual Machine."
  type        = string
}

variable "admin_password" {
  description = "(Required) The administrator password for the Azure Virtual Machine."
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "(Required) The storage account type for the OS disk, e.g., Standard_LRS or Premium_LRS."
  type        = string
}

variable "os_image_publisher" {
  description = "(Required) The publisher of the OS image, e.g., Canonical for Linux or MicrosoftWindowsServer for Windows."
  type        = string
}

variable "os_image_offer" {
  description = "(Required) The offer of the OS image, e.g., UbuntuServer for Linux or WindowsServer for Windows."
  type        = string
}

variable "os_image_sku" {
  description = "(Required) The SKU of the OS image, e.g., 18.04-LTS for Linux or 2019-Datacenter for Windows."
  type        = string
}

variable "os_image_version" {
  description = "(Required) The version of the OS image, e.g., latest for the latest version."
  type        = string
}

variable "subnet_id" {
  description = "(Required) The ID of the subnet where the Azure Virtual Machine will be deployed."
  type        = string
}

variable "os_type" {
  description = "(Required) The type of the operating system for the Azure Virtual Machine, e.g., Linux or Windows."
  validation {
    condition     = var.os_type == "Linux" || var.os_type == "Windows"
    error_message = "The os_type must be either 'Linux' or 'Windows'."
  }
  type = string
}

variable "data_collection_rule_id" {
  description = "(Required) The ID of the data collection rule to associate with the Azure Virtual Machine."
  type        = string
}

variable "private_ip_address" {
  description = "(Required) The private IP address to assign to the Azure Virtual Machine. If not specified, Azure will assign one automatically."
  type        = string
}

variable "public_ip_enable" {
  description = "(Optional) Whether to enable a public IP address for the Azure Virtual Machine. Defaults to false."
  type        = bool

  default = false
}