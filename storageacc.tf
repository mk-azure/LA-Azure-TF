# This will create a storage account, location, resource group and SA name will prompt 

variable "region" {
    description = "Azure Region"
}

variable "ResourceGroup" {
    description = "Name of the RG"
}

variable "Storage_Account_Name" {
    description = "Unique name for this storage account"
}

resource "azurerm_storage_account" "sa" {
    name = var.Storage_Account_Name
    resource_group_name = var.ResourceGroup
    location = var.location
    account_tier = "Standard"
    account_replication_type = "GRS"

    tags = {
        environment = "Terraform Storage"
        deployedfor = "LA-Azure-TF"
    }
}
