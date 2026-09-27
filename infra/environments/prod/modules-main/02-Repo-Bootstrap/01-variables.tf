# Variables

# Organization Details
variable "org_details" {
  description = "GitHub organization details."

  type = object({
    org_name = string
    org_id   = string
  })
}

# Github App Details
# Not being used anywhere, just for the sake of finding it quick. 
# Saves a lot of navigation time.
variable "github_app_details" {
  description = "GitHub App authentication details."

  type = object({
    app_id          = string
    installation_id = string
    private_key     = string
  })
  sensitive = true
}


# Github Repositories
variable "github_repositories" {
  type = list(any)
}

# NOTE: 
/*
The GitHub provider offers multiple ways to authenticate with GitHub API, we use the GitHub App 
authentication method  It requires: app_auth block with id, installation_id, and pem_file.
Here 
* PEM file is SENSITIVE, and must not be committed to repo. 
* App ID and Installation ID is Non-secret parameters

Also, Note that when you run Terraform Commands locally or within Runner, 
Terraform automatically fetches the values from any environment variable that starts with TF_VAR_. 
This is special behaviours Terraform. Terraform does automatic environment-variable mapping here. 
So even if you dont pass any variables via the command line, Terraform will still find them in the environment.

Read more here: https://developer.hashicorp.com/terraform/language/values/variables#command-line-variables

This implies that your pipeline must setup these environment variables correctly for Terraform to pick them up. 
So whether you are running TF locally or running on runner, you need to set these by: 

export TF_VAR_github_app_id=<your_github_app_id>
export TF_VAR_github_app_installation_id=<your_github_app_installation_id>
export TF_VAR_github_app_private_key=<your_github_app_private_key>

*/

variable "GITHUB_APP_ID" {
  type = number
}

variable "GITHUB_APP_INSTALLATION_ID" {
  type = number
}

variable "GITHUB_APP_PRIVATE_KEY" {
  type      = string
  sensitive = true
}

## End of Note
