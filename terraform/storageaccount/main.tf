terraform {
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "sushamatf"
    container_name       = "tfstatedevops"
    key                  = "terraformgithubexample.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_subnet" "datasubnet" {
  name                 = "storagesubnet"
  virtual_network_name = "vnet-sushma-demo"
  resource_group_name  = "rg-demo"
}

resource "azurerm_resource_group" "rg-demo" {
  name     = "rg-demo"
  location = "West Europe"
}

resource "azurerm_storage_account" "sa-demo" {
  name                     = "sademosushma"
  resource_group_name      = azurerm_resource_group.rg-demo.name
  location                 = azurerm_resource_group.rg-demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action = "Deny"
    virtual_network_subnet_ids = [data.azurerm_subnet.datasubnet.id]
  }
}
