
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

# Refer: docs/GitHub-App-Setup.md

provider "github" {
  owner = var.org_details.org_name # Github Org Name
  app_auth {
    id              = var.GITHUB_APP_ID
    installation_id = var.GITHUB_APP_INSTALLATION_ID
    pem_file        = var.GITHUB_APP_PRIVATE_KEY
  }
}
