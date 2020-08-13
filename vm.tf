data "azurerm_subnet" "tfsubnet" {
    name = "mySubnet"
    virtual_network_name = "myVnet"
    resource_group_name = "TFResourceGroup"
}

resource "azurerm_public_ip" "example" {
    name = "pubip1"
    location = "uksouth"
    resource_group_name = azurerm_subnet.tfsubnet.resource_group_name
    allocation_method = "Dynamic"
    sku = "Basic"
}

resource "azurerm_network_interface" "example" {
    name = "forge-nic" #var.nic_id 
    location = "uksouth"
    resource_group_name = azurerm_subnet.tfsubnet.resource_group_name

    ip_configuration {
        name = "ipconfig1"
        subnet_id = azurerm_subnet.tfsubnet.id 
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.example.id 
    }
}

resource "azurerm_storage_account" "sa" {
    name = "forgebootdiags123" #var.bdiag
    resource_group_name = azurerm_subnet.tfsubnet.resource_group_name
    location = azurerm_public_ip.example.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_virtual_machine" "example" {
    name = "forge" #var.servername 
    location = azurerm_public_ip.example.location
    resource_group_name = azurerm_subnet.tfsubnet.resource_group_name
    network_interface_ids = [azurerm_network_interface.example.id]
    vm_size = "Standard_B1s"
    delete_os_disk_on_termination = true 
    delete_data_disks_on_termination = false 
    
    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "16.04-LTS"
        version = "latest"
    }

    storage_os_disk {
        name = "osdisk1"
        disk_size_gb = "128"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name = "forge"
        admin_username = "vmadmin"
        admin_password = "Password12345!"
    }

    os_profile_linux_config {
        disable_password_authentication = false 
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.sa.primary_blob_endpoint
    }

}