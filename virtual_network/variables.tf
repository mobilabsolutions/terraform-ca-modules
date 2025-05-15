variable "environment" {
  description = "(Required) The environment name for the Azure resources names composition."
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resources exist."
}

variable "location_abbreviation" {
  description = "(Required) The abbreviation for the location of the Azure resources."
}

variable "workload" {
  description = "(Required) The workload or subcription name for the Azure resources names composition."
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resources."

  default = {}
}

variable "virtual_network_address_space" {
  description = "(Required) The IP address space for the Virtual Network."

  type = list(string)
}

# variable "firewall_enabled" {
#   description = "(Required) Specifies if the Azure Firewall should be enabled."

#   type    = bool
#   default = false
# }

# variable "bastion_enabled" {
#   description = "(Required) Specifies if the Azure Bastion should be enabled."

#   type    = bool
#   default = false
# }

# variable "virtual_network_gateway_enabled" {
#   description = "(Required) Specifies if the Azure Virtual Network Gateway should be enabled."

#   type    = bool
#   default = false

# }

# variable "application_gateway_enabled" {
#   description = "(Required) Specifies if the Azure Application Gateway should be enabled."

#   type    = bool
#   default = false

# }

# #New version of subnet variable
variable "subnets" {
  description = "Map of subnets with their address prefixes and optional delegations."
  type = map(object({
    address_prefix = string
    delegation = list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
  default = {}
}