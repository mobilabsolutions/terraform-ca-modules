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
  description = "(Required) The ID of the Virtual Network used for DNS resolver creation."
  type        = string
}

variable "dns_inbound_pe_subnet_id" {
  description = "(Required) The ID of the DNS Inbound Private Endpoint Subnet."
  type        = string
}

variable "dns_inbound_pe_subnet_id" {
  description = "(Required) The ID of the DNS Inbound Private Endpoint Subnet."
  type        = string
}

variable "dns_outbound_pe_subnet_id" {
  description = "(Required) The ID of the DNS Outbound Private Endpoint Subnet."
  type        = string
}

variable "dns_forwarding_rules" {
  description = <<EOF
    (Optional) List of domain names and DNS servers IP addresses for DNS resolver rules
    Example: 
    dns_forwarding_rules = {
        "onprem.local." = ["192.168.1.1"],
        "corp.com."     = ["10.10.0.1", "10.10.0.2"]
        }
  EOF
  type        = map(list(string))

  default = {}
}

variable "virtual_network_ids" {
  description = <<EOF
    (Optional) Map of Virtual Network IDs to be used in DNS Resolver Virtual network links
    Example:
      virtual_network_ids = {
          "vnet1" = "/subscriptions/.../virtualNetworks/vnet1",
          "vnet2" = "/subscriptions/.../virtualNetworks/vnet2"
      }
  EOF
  type        = map(string)

  default = {}
}