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

variable "time_zone" {
  description = "(Required) Specifies the timezone."
  type        = string
}

variable "windows_classifications_to_include" {
  description = <<EOF
    (Required) The Windows classifications to include.
    Example:
      windows_classifications_to_include = [
        "Critical",
        "Security"
        ]
  EOF
  type        = list(string)
}

variable "windows_kb_numbers_to_exclude" {
  description = <<EOF
    (Optional) The Windows KB numbers to exclude.
    Example:
      windows_kb_numbers_to_exclude = [
        "KB1234567",
        "KB7654321"
      ]
  EOF
  type        = list(string)

  default = []
}

variable "windows_kb_numbers_to_include" {
  description = <<EOF
    (Optional) The Windows KB numbers to include.
    Example:
      windows_kb_numbers_to_include = [
        "KB1234567",
        "KB7654321"
      ]
  EOF
  type        = list(string)

  default = []
}

variable "linux_classifications_to_include" {
  description = <<EOF
    (Required) The Linux classifications to include.
    Example:
      linux_classifications_to_include = [
        "Critical",
        "Security"
      ]
  EOF
  type        = list(string)
}

variable "linux_package_names_mask_to_exclude" {
  description = <<EOF
    (Optional) The Linux package names mask to exclude.
    Example:
      linux_package_names_mask_to_exclude = [
        "package1",
        "package2"
      ]
  EOF
  type        = list(string)

  default = []
}

variable "linux_package_names_mask_to_include" {
  description = <<EOF
    (Optional) The Linux package names mask to include.
    Example:
      linux_package_names_mask_to_include = [
        "package1",
        "package2"
      ]
  EOF
  type        = list(string)

  default = []
}

variable "start_time" {
  description = <<EOF
    (Required) The start time for the maintenance configuration.
    It should be in the format 'YYYY-MM-DD HH:MM'.
    Example: 
      start_time = '2025-06-02 23:00'.
  EOF
  type        = string
}

variable "environments_list" {
  description = <<EOF
    (Required) A list of environments to create dynamic scopes for.
    Example:
      environments_list = [
        "Dev",
        "Test",
        "Prod"
      ]
  EOF
  type        = set(string)
}