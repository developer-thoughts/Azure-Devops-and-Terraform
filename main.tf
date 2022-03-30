# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.97.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tf_azurerm" {
  name = "tfmainrg"
  location = "East US"
}

resource "azurerm_container_group" "tfcg_azurerm" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_azurerm.location
  resource_group_name       = azurerm_resource_group.tf_azurerm.name

  ip_address_type     = "public"
  dns_name_label      = "developerthoughts"
  os_type             = "Linux"

  container {
    name            = "weatherapi"
    image           = "acunacesar/weatherapi"
    cpu             = "1"
    memory          = "1"
    ports {
        port        = 80
        protocol    = "TCP"
    }
  }
}
