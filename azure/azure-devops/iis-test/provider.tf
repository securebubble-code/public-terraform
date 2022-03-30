
locals {
  prefix = var.sub_account_name != "" ? "${var.account_name}-${var.sub_account_name}" : var.account_name  
}

terraform {
  required_version = "~> 1.1.7"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.99.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Shared Data modules
data "azurerm_client_config" "current" {}

data "local_file" "linux-nginx-script" {
  filename = "${path.module}/misc_files/${var.linux_nginx_script}"
}

# Uncomment once KeyVault is in place and admin password entered
data "azurerm_key_vault_secret" "vm-adminpwd" {
  name         = "adminpassword"
  key_vault_id = azurerm_key_vault.kv-main.id
}

data "azurerm_key_vault_secret" "azdevops-pat" {
  name         = "azdevops-pat"
  key_vault_id = azurerm_key_vault.kv-main.id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}