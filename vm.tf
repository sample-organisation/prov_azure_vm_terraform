provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  tenant_id = "${var.azure_tenant_id}"
}

resource "azurerm_virtual_machine" "demo_vm_tf" {
  name                  = "demo_vm_tf"
  location              = "eastus"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${var.nic_id}"]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "demo_os_disk_tf"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "demovm"
    admin_username = "azureuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
        path     = "/home/azureuser/.ssh/authorized_keys"
        key_data = "${var.ssh_public_key}"
    }
  }

  tags {
      environment = "Terraform Demo"
  }
}
