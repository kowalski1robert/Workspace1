terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.22.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

  }

  required_version = "1.2.6"
}

provider "azurerm" {
  features {}
}
