# Variables

variable "github_repo_list" {
  type = list(any)
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

