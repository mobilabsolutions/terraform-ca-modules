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

variable "virtual_network_id" {
  description = "(Required) The ID of the Virtual Network."
  type        = string
}

variable "private_dns_zones" {
  description = <<EOF
    (Required) List of private DNS zones to be created.
    Example:
      private_dns_zones = [
        "privatelink.database.windows.net",
        "privatelink.servicebus.windows.net"
      ]
  EOF
  type        = list(string)
}