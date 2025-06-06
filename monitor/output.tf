output "resource_group_name" {
  value = azurerm_resource_group.rg_monitor.name

  description = "The name of the Resource Group for Network."
}

output "location" {
  value = azurerm_resource_group.rg_monitor.location

  description = "The location/region of the Resource Group for Network."
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_monitor.id

  description = "The ID of the Log Analytics Workspace."
}

output "windows_data_collection_rule_id" {
  value       = azurerm_monitor_data_collection_rule.dcr_windows.id
  description = "The ID of the Data Collection Rule for Windows. This will be used to associate with the Windows Virtual Machine."
}

output "linux_data_collection_rule_id" {
  value       = azurerm_monitor_data_collection_rule.dcr_linux.id
  description = "The ID of the Data Collection Rule for Linux. This will be used to associate with the Linux Virtual Machine."
}