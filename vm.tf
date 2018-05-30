provider "azurerm" {
  subscription_id = "${var.azure_subscription_id}"
  client_id = "${var.azure_client_id}"
  client_secret = "${var.azure_client_secret}"
  tenant_id = "${var.azure_tenant_id}"
}

resource "azurerm_storage_account" "demo_storage_account_tf" {
  name                     = "demostorageaccounttf"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "Terraform Demo"
  }
}

resource "azurerm_storage_container" "demo_storage_container_tf" {
  name                  = "vhds"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${azurerm_storage_account.demo_storage_account_tf.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "demo_vm_tf" {
  name                  = "demo_vm_tf"
  location              = "eastus"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${var.nic_id}"]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk1"
    vhd_uri       = "${azurerm_storage_account.demo_storage_account_tf.primary_blob_endpoint}${azurerm_storage_container.demo_storage_container_tf.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  storage_data_disk {
    name          = "datadisk0"
    vhd_uri       = "${azurerm_storage_account.demo_storage_account_tf.primary_blob_endpoint}${azurerm_storage_container.demo_storage_container_tf.name}/datadisk0.vhd"
    disk_size_gb  = "1023"
    create_option = "Empty"
    lun           = 0
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Thisis!ag00dpassword"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags {
    environment = "Terraform Demo"
  }
}

output "vm_id" {
  value = "${azure_virtual_machine.demo_vm_tf.id}"
}
