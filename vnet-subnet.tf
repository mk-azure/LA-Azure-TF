# Create virtual network 
resource "azurerm_virtual_network" "TFNet" {
    name = "myVnet"
    address_space = ["10.0.0.0/16"]
    location = "uksouth"
    resource_group_name = "TFResourceGroup"

    tags = {
        environment = "Terraform VNET"
    }
}

# Create subnet 
resource "azurerm_subnet" "tfsubnet" {
    name = "mySubnet"
    resource_group_name = azurerm_virtual_network.TFNet.resource_group_name
    virtual_network_name = azurerm_virtual_network.TFNet.name 
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "tfsubnet2" {
    name = "subnet2"
    resource_group_name = azurerm_virtual_network.TFNet.resource_group_name
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefixes = ["10.0.2.0/24"]
}