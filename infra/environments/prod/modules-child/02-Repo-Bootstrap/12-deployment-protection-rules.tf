# Configure deployment protection settings for all repository environments.
#
# Required reviewers are resolved from GitHub usernames to GitHub user IDs.
# The wait timer and reviewer configuration are sourced from tfvars.

resource "github_repository_environment" "deployment_protection_rules" {
  for_each = {
    for rule in local.deployment_protection_rules_list :
    rule.uid => rule
  }

  repository  = github_repository.landing_zone_repo[each.value.repo_uid].name
  environment = each.value.environment

  wait_timer = each.value.wait_timer

  can_admins_bypass   = true
  prevent_self_review = false

  reviewers {
    users = [
      for username in each.value.required_reviewers_usernames :
      data.github_user.reviewers[username].id
    ]
  }

  depends_on = [
    github_repository_environment.environments
  ]
}