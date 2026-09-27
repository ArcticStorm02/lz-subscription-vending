# Data sources:

data "github_team" "DevOps_Admins" {
  slug = local.TeamName_DevOps_Admins
}

data "github_team" "DevOps_Developers" {
  slug = local.TeamName_DevOps_Developers
}

# data "github_user" "current" {
#   username = "rs-rihc"
# }

# data "github_user" "current" {
#   username = "rs-rihc"
# }

data "github_user" "reviewers" {
  for_each = toset(flatten([
    for rule in local.deployment_protection_rules_list :
    rule.required_reviewers_usernames
  ]))

  username = each.value
}