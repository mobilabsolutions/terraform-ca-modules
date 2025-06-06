output "public_ip" {
  value = length(azurerm_public_ip.vm_pip) > 0 ? azurerm_public_ip.vm_pip[0].ip_address : null

  description = "The public IP address of the virtual machine."
}