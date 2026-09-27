

resource "github_repository_environment" "environments" {
  for_each = toset([
    "Lz-INTG-Dev",
    "Lz-INTG-Acc",
    "Lz-INTG-Prod"
  ])

  repository  = github_repository.ihc_lz_repo.name
  environment = each.value
}

# Env Vars: 


resource "github_actions_environment_variable" "env_vars" {

  for_each = local.environment_variables

  repository    = github_repository.ihc_lz_repo.name
  environment   = each.value.environment
  variable_name = each.value.name
  value         = each.value.value

  depends_on = [
    github_repository_environment.environments
  ]
}
