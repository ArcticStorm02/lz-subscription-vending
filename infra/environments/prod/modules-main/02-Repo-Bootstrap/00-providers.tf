
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
  owner = "ArcticStorm02"

  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_private_key
  }
}

# provider "github" {

#   owner = "Royal-IHC-BV" # The Github Org name 
#   app_auth {
#     id              = "XXXXXXX"   # Github App ID from https://github.com/settings/apps/rs-repo-bootstrap
#     installation_id = "XXXXXXXXX" # This is present in URL: https://github.com/organizations/ArcticStorm02/settings/installations/165387746
#     # This is generated on the App Settings page > Private keys
#     pem_file = file("key.2026-09-22.private-key.pem") # WARNING SECRET: Check if you can use GH ENV Secret instead
#   }
# }


# How to create Github App: 
# Org > Settings > Developer Settings > Github Apps > New Github Apps > 
# Home URL Page: https://github.com/ArcticStorm02

# How to Install Github App on Repo: 
# Repo > Settings > Integrations: Github Apps >  

# provider "github" {

#   owner = "ArcticStorm02" # The Github Org name 
#   app_auth {
#     id              = "XXXXXXX"   # Github App ID from https://github.com/settings/apps/rs-repo-bootstrap
#     installation_id = "165387746" # This is generated after GitHub App installation on https://github.com/settings/apps
#     # This is generated on the App Settings page > Private keys
#     pem_file = file("key.2026-09-22.private-key.pem") # WARNING SECRET: Check if you can use GH ENV Secret instead
#   }
# }

# provider "github" {
#   owner = "ArcticStorm02" # The Github Org name 
# }


# provider "github" {
#   owner = "ArcticStorm02"

#   app_auth {
#     id              = var.github_app_id
#     installation_id = var.github_app_installation_id
#     pem_file        = var.github_app_private_key
#   }
# }