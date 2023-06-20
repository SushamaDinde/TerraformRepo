terraform {
  backend "azurerm" {
    resource_group_name  = "tamopstfstates"
    storage_account_name = "sushamatf"
    container_name       = "tfstatedevops"
    key                  = "terraformgithubsqlserver.tfstate"
  }
}

provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "sqldemo" {
  name = "rg-demo"
}

resource "azurerm_mssql_server" "sqldemo" {
  name                         = "sqlserverdemo"
  resource_group_name          = data.azurerm_resource_group.sqldemo.name
  location                     = data.azurerm_resource_group.sqldemo.location
  version                      = "12.0"
  administrator_login          = "sushma"
  administrator_login_password = "Sushma@12345678"
  minimum_tls_version          = "1.2"

  #   azuread_administrator {
  #     login_username = "AzureAD Admin"
  #     object_id      = "00000000-0000-0000-0000-000000000000"
  #   }

  #   tags = {
  #     environment = "production"
  #   }
}