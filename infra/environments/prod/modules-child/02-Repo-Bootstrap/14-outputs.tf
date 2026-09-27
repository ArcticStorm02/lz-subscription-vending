
# Generate Output which will be used in Subscription Vending for Phase 2 execution for
# Federated credentials
output "repository_summary" {
  description = "Summary of Landing Zone repositories created by this module."

  value = {
    for repo in local.github_repo_list :
    repo.repo_name => {
      repository_url = github_repository.landing_zone_repo[repo.uid].html_url

      environments = [
        for env in local.github_environment_list :
        env.environment_name
        if env.repo_uid == repo.uid
      ]

      develop_branch = github_branch.develop_branch[repo.uid].branch
    }
  }
}

output "repository_count" {
  description = "Number of Landing Zone repositories created."

  value = length(local.github_repo_list)
}

output "repository_names" {
  description = "Names of Landing Zone repositories created."

  value = [
    for repo in local.github_repo_list :
    github_repository.landing_zone_repo[repo.uid].name
  ]
}

output "repository_urls" {
  description = "URLs of Landing Zone repositories created."

  value = [
    for repo in local.github_repo_list :
    github_repository.landing_zone_repo[repo.uid].html_url
  ]
}

output "repository_environment_count" {
  description = "Total number of GitHub environments created."

  value = length(local.github_environment_list)
}

output "repositories" {
  description = "Details of Landing Zone repositories created."

  value = {
    for repo in local.github_repo_list :
    repo.uid => {
      name = github_repository.landing_zone_repo[repo.uid].name
      url  = github_repository.landing_zone_repo[repo.uid].html_url
    }
  }
}

output "federated_credentials" {
  description = "Federated credentials created for GitHub Actions."

  value =  "Yet to be done"
}