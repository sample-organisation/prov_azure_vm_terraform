provider azurerm {
  # azure_subscription_id = "${var.azure_subscription_id}"
  azure_client_id = "${var.azure_client_id}"
  azure_client_secret = "${var.azure_client_secret}"
  azure_tenant_id = "${var.azure_tenant_id}"
}

resource "azurerm_resource_group" "myterraformgroup" {
    name     = "myResourceGroup"
    location = "eastus"

    tags {
        environment = "Terraform Demo"
    }
}
