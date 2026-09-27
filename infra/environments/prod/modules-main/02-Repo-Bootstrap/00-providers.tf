
# Configure required providers
terraform {
  required_providers {
    # Required for managing GitHub repositories and resources
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "Royal-IHC-BV" # Name of the Org
}