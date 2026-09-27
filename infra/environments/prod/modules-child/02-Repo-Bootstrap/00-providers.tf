# Terraform Providers: 
# Only 1 Provider is required for managing the GitHub resources
terraform {
  required_providers {
    # Required for managing GitHub repositories and resources
    github = {
      source = "integrations/github"
    }
  }
}
