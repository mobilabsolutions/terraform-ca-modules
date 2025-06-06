resource "azurerm_public_ip" "vm_pip" {
  count = var.public_ip_enable ? 1 : 0

  name                = "pip-${var.vm_name}-${var.location_abbreviation}-${var.environment}-001"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-${var.vm_name}-${var.location_abbreviation}-${var.environment}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "ipconfig-${var.vm_name}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address

    public_ip_address_id = var.public_ip_enable ? azurerm_public_ip.vm_pip[0].id : null
  }
}

resource "azurerm_linux_virtual_machine" "linux" {
  count = var.os_type == "Linux" ? 1 : 0

  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  encryption_at_host_enabled      = true
  tags                            = var.tags

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    name                 = "osdisk-${var.os_type}-${var.vm_name}-001"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.os_image_publisher
    offer     = var.os_image_offer
    sku       = var.os_image_sku
    version   = var.os_image_version
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_virtual_machine_extension" "linux_vm_ama_extension" {
  count = var.os_type == "Linux" ? 1 : 0

  name                       = "${var.vm_name}-ama-extension"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux[0].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = var.tags
}

resource "azurerm_monitor_data_collection_rule_association" "linux_vm" {
  count = var.os_type == "Linux" ? 1 : 0

  name                    = "linux-${var.vm_name}-dcr-association"
  target_resource_id      = azurerm_linux_virtual_machine.linux[0].id
  data_collection_rule_id = var.data_collection_rule_id
  description             = "Data collection rule association for Linux VM ${var.vm_name}"
}


resource "azurerm_windows_virtual_machine" "windows" {
  count = var.os_type == "Windows" ? 1 : 0

  name                              = var.vm_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  size                              = var.vm_size
  admin_username                    = var.admin_username
  admin_password                    = var.admin_password
  encryption_at_host_enabled        = true
  vm_agent_platform_updates_enabled = true
  tags                              = var.tags

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    name                 = "osdisk-${var.os_type}-${var.vm_name}-001"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.os_image_publisher
    offer     = var.os_image_offer
    sku       = var.os_image_sku
    version   = var.os_image_version
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_virtual_machine_extension" "windows_vm_ama_extension" {
  count = var.os_type == "Windows" ? 1 : 0

  name                       = "${var.vm_name}-ama-extension"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows[0].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = var.tags
}

resource "azurerm_monitor_data_collection_rule_association" "windows_vm" {
  count = var.os_type == "Windows" ? 1 : 0

  name                    = "windows-${var.vm_name}-dcr-association"
  target_resource_id      = azurerm_windows_virtual_machine.windows[0].id
  data_collection_rule_id = var.data_collection_rule_id
  description             = "Data collection rule association for Windows VM ${var.vm_name}"
}

