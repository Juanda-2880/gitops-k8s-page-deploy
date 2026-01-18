terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" 
    }
  }
}

# Provider Configuration
provider "azurerm" {
  features {}
  # Often required in educational or restricted corporate subscriptions
  # to avoid permission errors when registering new resource providers.
  skip_provider_registration = true 
}