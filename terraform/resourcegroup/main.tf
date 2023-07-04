terraform {
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "sushamatf"
    container_name       = "tfstatedevops"
    key                  = "terraformgithubresourcegroup.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "demoresourcegroup" {
  name     = "rg-demo2"
  location = "West Europe"
}
