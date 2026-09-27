
locals {



  github_repo_list = flatten([
    for repo in var.github_repositories : {
      uid = replace("${repo.repo_name}|${repo.project_code}", " ", "-")


      # if repo_name is empty string then populate: 
      repo_name = "${local.company_code}-${local.repo_name_prefix}-${repo.project_code}"
      repo_url  = "<Update This Value>"

      repo_name    = repo.repo_name
      project_code = repo.project_code
      repo_url     = repo.repo_url
      environments = repo.environments
    }
  ])


  # Create one record for every repository/environment combination.
  github_environment_list = flatten([
    for repo in local.github_repo_list : [
      for env in repo.environments : {
        uid              = "${repo.uid}|${env.environment_name}"
        repo_uid         = repo.uid
        repo_name        = repo.repo_name
        environment_name = env.environment_name
      }
    ]
  ])


  # Create one record for every repository/environment/environment-variable
  # combination.
  environment_variables_list = flatten([
    for repo in local.github_repo_list : [
      for env in repo.environments : [
        for variable_name, variable_value in env.ARM_Environment_Vars : {
          uid         = "${repo.uid}|${env.environment_name}|${variable_name}"
          repo_uid    = repo.uid
          repo_name   = repo.repo_name
          environment = env.environment_name
          name        = variable_name
          value       = variable_value
        }
      ]
    ]
  ])

  # Create one record for every deployment protection rule configured
  # for every repository environment.

  deployment_protection_rules_list = flatten([
    for repo in local.github_repo_list : [
      for env in repo.environments : [
        for rule in env.deployment_protection_rules : {
          uid                          = "${repo.uid}|${env.environment_name}|${rule.name}"
          repo_uid                     = repo.uid
          repo_name                    = repo.repo_name
          environment                  = env.environment_name
          rule_name                    = rule.name
          wait_timer                   = rule.wait_timer
          required_reviewers_usernames = rule.required_reviewers_usernames
        }
      ]
    ]
  ])

}
 
