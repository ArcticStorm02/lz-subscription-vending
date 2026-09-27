
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
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_private_key
  }
}
