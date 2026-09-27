
# List of Github Repo for Each Landing Zone (containing environments - dev, acc, prod)

variable "github_repos" {
  type = list(object({
    org_name            = string
    repo_name           = string
    project_code        = string
    environments        = list(string)
    repo_url            = string
    group_role_assignments = list(object({
      security_group_name = string
      roleid_list         = list(string)
    }))
  }))
}

# For provider setup, these Must not be passed by the tfvars
# Instead Github action should be able to do this using Environment and populate using TF_Vars_*
# within the github action pipeline . 
# Local environment may not work

variable "github_app_id" {
  type = number
}

variable "github_app_installation_id" {
  type = number
}

variable "github_app_private_key" {
  type      = string
  sensitive = true
}

