
terraform {
  required_providers {
    # Required for managing GitHub repositories and resources
    github = {
      source = "integrations/github"
    }
  }
}
