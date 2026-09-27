# Create Github Repo: 
resource "github_repository" "landing_zone_repo" {
  for_each    = { for repo in local.github_repo_list : repo.uid => repo }
  name        = each.value.repo_name
  description = each.value.repo_description

  visibility             = "private"
  auto_init              = true
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  has_discussions        = false
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true
  archived               = false
  #vulnerability_alerts = true

  topics = [
    "terraform",
    "azure",
    "landing-zone",
    "infrastructure-as-code"
  ]

  lifecycle {
    prevent_destroy = true
  }
}

# Enable Dependabot alert: 
resource "github_repository_vulnerability_alerts" "ihc_lz_repo" {
  for_each   = { for repo in local.github_repo_list : repo.uid => repo }
  repository = github_repository.landing_zone_repo[each.value.uid].name
  enabled    = true
}
