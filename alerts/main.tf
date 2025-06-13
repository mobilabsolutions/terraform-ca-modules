resource "azurerm_resource_group" "rg_alerts" {
  name     = "rg-alerts-${var.location_abbreviation}-${var.environment}-001"
  location = var.location
  tags     = var.tags
}

resource "azurerm_monitor_action_group" "ag-operations" {
  name                = "Operations-ActionGroup"
  resource_group_name = azurerm_resource_group.rg_alerts.name
  short_name          = "OperationsAG"
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name          = email_receiver.key
      email_address = email_receiver.value
    }
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "vm_cpu_utilization_high" {
  name                = "VM CPU utilization is High"
  description         = "Alert when VM CPU utilization is above 80 percent"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 2
  evaluation_frequency    = "PT5M"
  window_duration         = "PT15M"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      InsightsMetrics
      | where TimeGenerated >= ago(15m)
      | where Origin == "vm.azm.ms"
      | where Namespace == "Processor" and Name == "UtilizationPercentage"
      | summarize CPUPercentageAverage = avg(Val) by Computer, Namespace, Name, Tags
      | where CPUPercentageAverage >= 80
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Tags"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "CPUPercentageAverage"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "vm_cpu_utilization_critical" {
  name                = "VM CPU utilization is Critical"
  description         = "Alert when VM CPU utilization is above 90 percent"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 1
  evaluation_frequency    = "PT5M"
  window_duration         = "PT1H"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      InsightsMetrics
      | where TimeGenerated >= ago(15m)
      | where Origin == "vm.azm.ms"
      | where Namespace == "Processor" and Name == "UtilizationPercentage"
      | summarize CPUPercentageAverage = avg(Val) by Computer, Namespace, Name, Tags
      | where CPUPercentageAverage >= 90
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Tags"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "CPUPercentageAverage"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "vm_memory_utilization_high" {
  name                = "Memory utilization is High"
  description         = "Alert when VM Memory utilization is above 80 percent"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 2
  evaluation_frequency    = "PT5M"
  window_duration         = "PT15M"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      InsightsMetrics
      | where TimeGenerated >= ago(15m)
      | where Origin == "vm.azm.ms"
      | where Namespace == "Memory" and Name == "AvailableMB"
      | extend TotalMemory = toreal(todynamic(Tags)["vm.azm.ms/memorySizeMB"]) | extend AvailableMemoryPercentage = (toreal(Val) / TotalMemory) * 100.0
      | summarize AvailableMemoryInPercentageAverage = avg(AvailableMemoryPercentage) by Computer, Namespace, Name, Tags
      | where AvailableMemoryInPercentageAverage <= 20
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Tags"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "AvailableMemoryInPercentageAverage"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "vm_memory_utilization_critical" {
  name                = "Memory utilization is Critical"
  description         = "Alert when VM Memory utilization is above 80 percent"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 1
  evaluation_frequency    = "PT5M"
  window_duration         = "PT15M"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      InsightsMetrics
      | where TimeGenerated >= ago(15m)
      | where Origin == "vm.azm.ms"
      | where Namespace == "Memory" and Name == "AvailableMB"
      | extend TotalMemory = toreal(todynamic(Tags)["vm.azm.ms/memorySizeMB"]) | extend AvailableMemoryPercentage = (toreal(Val) / TotalMemory) * 100.0
      | summarize AvailableMemoryInPercentageAverage = avg(AvailableMemoryPercentage) by Computer, Namespace, Name, Tags
      | where AvailableMemoryInPercentageAverage <= 10
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Tags"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "AvailableMemoryInPercentageAverage"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "vm_disk_space_high" {
  name                = "VM Disk space usage is High"
  description         = "Alert when VM Disk Free Space is less than 20 percent"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 2
  evaluation_frequency    = "PT5M"
  window_duration         = "PT1H"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      InsightsMetrics
      | where TimeGenerated >= ago(15m)
      | where Origin == "vm.azm.ms"
      | where Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"
      | summarize MinimalValue = min(Val) by Computer, Namespace, Name, Tags
      | where MinimalValue <= 20
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Tags"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "MinimalValue"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "vm_disk_space_critical" {
  name                = "VM Disk space usage is Critical"
  description         = "Alert when VM Disk Free Space is less than 10 percent"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 1
  evaluation_frequency    = "PT5M"
  window_duration         = "PT1H"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      InsightsMetrics
      | where TimeGenerated >= ago(15m)
      | where Origin == "vm.azm.ms"
      | where Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"
      | summarize MinimalValue = min(Val) by Computer, Namespace, Name, Tags
      | where MinimalValue <= 10
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Tags"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "MinimalValue"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "failed_backup_jobs" {
  name                = "Scheduled Backup Jobs failed"
  description         = "Alert when Scheduled Backup Jobs have failed state"
  location            = azurerm_resource_group.rg_alerts.location
  resource_group_name = azurerm_resource_group.rg_alerts.name

  scopes                  = [var.log_analytics_workspace_id]
  severity                = 2
  evaluation_frequency    = "PT6H"
  window_duration         = "P1D"
  enabled                 = true
  auto_mitigation_enabled = true
  tags                    = var.tags

  criteria {
    query                   = <<-QUERY
      AddonAzureBackupJobs 
      |where JobFailureCode != "Success" and AdHocOrScheduledJob == "Scheduled"
      |project TimeGenerated, RSV_Name = tostring(split(ResourceId, "/VAULTS/", 1)), JobStartDateTime, Resource=tostring(split(BackupItemUniqueId,";", 4)), JobFailureCode, JobStatus
      QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

    dimension {
      name     = "RSV_Name"
      operator = "Include"
      values   = ["*"]
    }
    dimension {
      name     = "Resource"
      operator = "Include"
      values   = ["*"]
    }

    dimension {
      name     = "JobFailureCode"
      operator = "Include"
      values   = ["*"]
    }
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag-operations.id]
  }
}

