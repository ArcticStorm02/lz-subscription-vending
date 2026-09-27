# @author: Rajesh Swarnkar

# List of GitHub repositories for each Landing Zone
# containing environments such as Dev, Acc, and Prod.

variable "github_repositories" {
  description = <<-EOD
  List of GitHub repositories and their environment configurations required
  for secure and consistent Landing Zone subscription onboarding.

  Each repository represents an Application Landing Zone and contains its
  associated environments.

  Required attributes:   
    
    project_code  -> Short, unique project identifier (maximum 5 characters)
    repo_name     -> GitHub repository name. Must follow the pattern:
                     ihc-lz-<lowercase-name>
    repo_description -> Brief description of the repository
    repo_url      -> URL of the GitHub repository
    environments  -> List of GitHub environments and their configuration

  Purpose:
    This variable enables automated and repeatable provisioning of Landing Zone
    repositories and their associated GitHub environments.
  EOD

  type = list(object({
    project_code     = string
    repo_name        = string
    repo_description = string
    repo_url         = string

    environments = list(object({
      environment_name = string

      ARM_Environment_Vars = object({
        ARM_CLIENT_ID       = string
        ARM_SUBSCRIPTION_ID = string
        ARM_TENANT_ID       = string
      })

      deployment_protection_rules = list(object({
        name                         = string
        required_reviewers_usernames = list(string)
        wait_timer                   = optional(number)
      }))
    }))
  }))

  validation {
    condition = alltrue([
      for repo in var.github_repositories :
      length(repo.project_code) <= 5
    ])

    error_message = "project_code must not exceed 5 characters."
  }

  validation {
    condition     = alltrue([for repo in var.github_repositories : can(regex("^ihc-lz-[a-z]+$", repo.repo_name))])
    error_message = "repo_name must follow the pattern 'ihc-lz-<lowercase-name>', for example 'ihc-lz-intg'."
  }

  validation {
    condition     = alltrue([for repo in var.github_repositories : can(regex("^https://github\\.com/[A-Za-z0-9_.-]+/ihc-lz-[a-z]+\\.git$", repo.repo_url))])
    error_message = "repo_url must be a valid GitHub HTTPS URL for an ihc-lz-* repository, for example 'https://github.com/Royal-IHC-BV/ihc-lz-intg.git'."
  }

  validation {
    condition = alltrue([
      for repo in var.github_repositories :
      alltrue([
        for env in repo.environments :
        alltrue([
          for rule in env.deployment_protection_rules :
          rule.wait_timer == null || (
            rule.wait_timer >= 1 &&
            rule.wait_timer <= 43200
          )
        ])
      ])
    ])
    error_message = "wait_timer must be null or a number between 1 and 43200 seconds."
  }
}



