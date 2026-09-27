
# List of Github Repo for Each Landing Zone (containing environments - dev, acc, prod)

variable "github_repo_list" {
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

