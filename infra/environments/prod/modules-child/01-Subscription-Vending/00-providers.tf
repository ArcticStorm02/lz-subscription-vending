terraform {
    required_providers {
    azurerm = {
      version = "~>4.0"
      configuration_aliases = [
        azurerm,
        azurerm.LzConnectivity,
        azurerm.LzManagement,
        # azurerm.LzSharedServices,
        # azurerm.LzSecurity,
        ]
    }
    azapi = {
      source = "Azure/azapi"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}


