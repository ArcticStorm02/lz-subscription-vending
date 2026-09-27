# Assign existing GitHub teams to all Landing Zone repositories.
#
# DevOps_Admins:
#   - Manage repository settings and policies
#   - Manage environments
#   - Approve releases
#
# DevOps_Developers:
#   - Commit and push code
#   - Create and manage pull requests
#   - Merge pull requests
#   - Run pipelines
#
# Teams are existing GitHub organization teams and are therefore referenced
# through data sources rather than created by this module.

resource "github_team_repository" "DevOps_Admins" {
  for_each    = { for repo in local.github_repo_list : repo.uid => repo }
  team_id    = data.github_team.DevOps_Admins.id
  repository = github_repository.landing_zone_repo[each.value.uid].name
  permission = "admin"
}

resource "github_team_repository" "DevOps_Developers" {
  for_each    = { for repo in local.github_repo_list : repo.uid => repo }
  team_id    = data.github_team.DevOps_Developers.id
  repository = github_repository.landing_zone_repo[each.value.uid].name
  permission = "push" # GitHub's repository roles are: Read, Triage, Write = Push, Maintain, Admin.
}


