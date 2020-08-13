terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "MKAzure"

    workspaces {
      name = "LA-Azure-TF"
    }
  }
}

provider "azurerm" {
  features {}
  version = "v2.21.0"
}

resource "azurerm_resource_group" "rg" {
  name = "TFResourceGroup"
  location = "uksouth"

  tags = {
    environment = "Terraform"
    deployedfor = "LA-Azure-TF"
  }
}