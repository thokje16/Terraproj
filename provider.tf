terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.7"
    }
  }
}


provider "azurerm" {
  features {}
   subscription_id = "b8023013-bccf-48f8-aa8e-c7cc2aab91cb"
}


resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
resource "time_sleep" "wait_for_rg" {
  depends_on = [azurerm_resource_group.main]
  create_duration = "10s"  # Adjust duration as needed
}