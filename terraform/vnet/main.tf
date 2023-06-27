terraform {
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "sushamatf"
    container_name       = "tfstatedevops"
    key                  = "terraformgithubvnet.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "vnetrgdemo" {
  name = "rg-demo"
}

resource "azurerm_virtual_network" "vnet-sushma" {
  name                = "vnet-sushma-demo"
  location            = data.azurerm_resource_group.vnetrgdemo.location
  resource_group_name = data.azurerm_resource_group.vnetrgdemo.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "databasesubnet"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "websitesubnet"
    address_prefix = "10.0.2.0/24"

  }

  subnet {
    name           = "storagesubnet"
    address_prefix = "10.0.3.0/24"

  }


}