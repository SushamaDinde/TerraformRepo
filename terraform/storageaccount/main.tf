terraform {
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "sushamatf"
    container_name       = "tfstatedevops"
    key                  = "terraformgithubstorageaccount.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "varrgdemo" {
  name = "rg-demo2"
}

resource "azurerm_storage_account" "demostorageaccount" {
  name                     = "sasushma"
  resource_group_name      = data.azurerm_resource_group.varrgdemo.name
  location                 = data.azurerm_resource_group.varrgdemo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"


}
