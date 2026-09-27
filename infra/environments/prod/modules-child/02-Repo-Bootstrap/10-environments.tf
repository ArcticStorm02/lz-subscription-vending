

# Create all configured GitHub Environments for all Landing Zone repositories.
resource "github_repository_environment" "environments" {
  for_each    = { for env in local.github_environment_list : env.uid => env }
  repository  = github_repository.landing_zone_repo[each.value.repo_uid].name
  environment = each.value.environment_name
}



# Create environment variables for each configured GitHub Environment.
resource "github_actions_environment_variable" "env_vars" {
  for_each      = { for env_var in local.environment_variables_list : env_var.uid => env_var }
  repository    = github_repository.landing_zone_repo[each.value.repo_uid].name
  environment   = each.value.environment
  variable_name = each.value.name
  value         = each.value.value

  depends_on = [
    github_repository_environment.environments
  ]
}
