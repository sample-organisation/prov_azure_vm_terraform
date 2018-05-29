# main creds for Azure connection
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
}

variable "azure_client_id" {
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
}

variable "resource_group_name" {
  description = "Resource Group Name"
}

variable "nic_id" {
  description = "Network Interface Card ID"
}

variable "ssh_public_key" {
  description = "Public SSH key for accessing the machine"
}
