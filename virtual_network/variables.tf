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

variable "virtual_network_address_space" {
  description = "(Required) The IP address space for the Virtual Network."
  type        = list(string)

}

variable "subnet_prefixes" {
  description = "(Required) The IP address ranges for Subnets of the Virtual Network."
  type        = map(string)

}

variable "subnet_delegations" {
  description = <<EOF
  (Optional) Some subnets require Delegations, for instance, subnets of DNS resolver private endpoints
  in the DNS zone. This variable allows you to define those delegations.
  Example:
    subnet_delegations = {
      snet-dnsie-prod-001 = [{
        name = "Microsoft.Network.dnsResolvers"
        service_delegation = {
          name    = "Microsoft.Network/dnsResolvers"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }]
      snet-dnsoe-prod-001 = [{
        name = "Microsoft.Network.dnsResolvers"
      service_delegation = {
        name    = "Microsoft.Network/dnsResolvers"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }]
    } 
  EOF 

  type = map(list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  })))

  default = {}
}