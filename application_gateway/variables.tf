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

variable "workload" {
  description = "(Required) The workload or subcription name for the Azure resources names composition."
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

variable "virtual_network_name" {
  description = "(Required) The Name of the Virtual Network where the Bastion should be created."
  type        = string
}


variable "application_gateway_subnet_id" {
  description = "(Required) The ID of the Application Gateway Subnet."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group for Application Gateway."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "(Required) The Log Analytics Workspace ID of Management subscription."
  type        = string
}