

# Need to use data sources for the Existing team

/*
data "github_team" "DevOps_Admins" {
  slug = "RIHC-Azure-IaC-DevOps-Admins"
}

data "github_team" "DevOps_Developers" {
  slug = "RIHC-Azure-IaC-DevOps-Developers"
}

resource "github_team_repository" "DevOps_Admins" {
  team_id    = data.github_team.DevOps_Admins.id
  repository = github_repository.ihc_lz_repo.name
  permission = "admin"
}

resource "github_team_repository" "DevOps_Developers" {
  team_id    = data.github_team.DevOps_Developers.id
  repository = github_repository.ihc_lz_repo.name
  permission = "write" # GitHub's repository roles are: Read, Triage, Write = Push, Maintain, Admin.
} 

*/ 


/*
Reason: 

Admins
    Manage repo
    Manage policies
    Manage environments
    Approve releases

Developers
    Commit code
    Raise PRs
    Merge PRs
    Run pipelines

*/

