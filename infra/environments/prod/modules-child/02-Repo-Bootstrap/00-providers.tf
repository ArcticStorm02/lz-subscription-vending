
terraform {
  required_providers {
    # Required for managing GitHub repositories and resources
    github = {
      source = "integrations/github"
    }
  }
}

provider "github" {

  owner = "Royal-IHC-BV" # The Github Org name 
  app_auth {
    id              = "XXXXXXX"   # Github App ID from https://github.com/settings/apps/rs-repo-bootstrap
    installation_id = "XXXXXXXXX" # This is generated after GitHub App installation on https://github.com/settings/apps
    # This is generated on the App Settings page > Private keys
    pem_file = file("key.2026-09-22.private-key.pem") # WARNING SECRET: Check if you can use GH ENV Secret instead
  }
}