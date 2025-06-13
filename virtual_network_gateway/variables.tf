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

variable "workload" {
  description = "(Required) The workload or subcription name for the Azure resources names composition."
  type        = string
}

variable "virtual_network_gateway_subnet_id" {
  description = "(Required) The ID of the Azure Virtual Network Gateway Subnet."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group for Firewall."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "(Required) The Log Analytics Workspace ID of Management subscription."
  type        = string
}

variable "local_network_gateway_ip_address" {
  description = "(Required) The IP address of the Local Network Gateway (Public IP address of On-premisses network device)."
  type        = string
}

variable "local_network_gateway_address_space" {
  description = <<EOF
    (Required) The address space of the Local Network Gateway (On-premisses network address space).
    Example:
      local_network_gateway_address_space = [
        "172.16.0.0/24",
        "192.168.0.0/24"
      ]
  EOF
  type        = list(string)
}

variable "shared_key" {
  description = "(Required) The shared key for the VPN gateway connection."
  type        = string
  sensitive   = true
}