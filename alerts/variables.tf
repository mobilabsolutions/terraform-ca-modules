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

variable "email_receivers" {
  description = <<EOF
    (Required) A list of email receivers for the action group.
    Example: 
      action_group_email_receivers = {
          support = "support.team@example.com",
          internal = "user2@gmail.com"
      }
  EOF
  type        = map(string)
}

variable "subscription_id" {
  description = "(Required) The subscription ID for the Azure resources."
  type        = string

}

variable "log_analytics_workspace_id" {
  description = "(Required) The Log Analitycs Workspace ID for the Azure resources."
  type        = string
}
