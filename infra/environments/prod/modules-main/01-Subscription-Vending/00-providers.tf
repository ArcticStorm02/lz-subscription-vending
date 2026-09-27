
# Configure required providers
terraform {
  backend "azurerm" {
  }
  #   backend "local" {
  #     path = "./path/to/local.tfstate"
  #   }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0" # lock a version
    }
    # Required for random string generation
    random = {
      source  = "hashicorp/random"
      version = "3.8.0" # lock a version
    }
    # Required for managing the TFL4 Service principal
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.7.0" # lock a version
    }
    # Required for update (patch) tags on Target Subscription
    azapi = {
      source  = "Azure/azapi"
      version = "2.8.0"
    }
    # Required for managing GitHub repositories and resources
    # github = {
    #   source  = "integrations/github"
    #   version = "~> 6.0"
    # }
  }
}


# Default provider
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
}

provider "random" {
  # Configuration options
}

provider "azuread" {
  # Configuration options
}

# provider "github" {
#   owner = "Royal-IHC-BV"
# }


provider "azapi" {
  # Configuration options
}


# Aliases for other subscriptions

provider "azurerm" {
  alias           = "LzConnectivity"
  subscription_id = "62fc9eae-6918-45ba-bb91-d048a3a11190"
  features {}
  resource_provider_registrations = "none"
}

# provider "azurerm" {
#   alias           = "LzIdentity"
#   subscription_id = "f38e4aea-7f5d-44af-bc3c-2a73d91b9bd4"
#   features {}
#   resource_provider_registrations = "none"
# }

# provider "azurerm" {
#   alias           = "LzSecurity"
#   subscription_id = "53e34ea5-a4cf-445c-a181-8ffc384887fc"
#   features {}
#   resource_provider_registrations = "none"
# }

provider "azurerm" {
  alias           = "LzManagement"
  subscription_id = "21a4d366-80fb-4f2a-9589-f804cf565065"
  features {}
  resource_provider_registrations = "none"
}


# provider "azurerm" {
#   alias           = "LzSharedServices"
#   subscription_id = "89d8d75b-fdf4-49f6-9b12-765c744fadf1"
#   features {}
#   resource_provider_registrations = "none"
# }
