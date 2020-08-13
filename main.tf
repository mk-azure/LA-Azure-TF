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