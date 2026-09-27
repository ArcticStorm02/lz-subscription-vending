


# Create Github Repo: 


resource "github_repository" "ihc_lz_repo" {
  for_each  = { for repo in local.subscription_list : sub.subscription_id => sub }
  name        = "ihc-lz-sprt"
  description = "SmartPort Repository"

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
  #vulnerability_alerts = true
  archived = false

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


# resource "github_repository_vulnerability_alerts" "ihc_lz_repo" {
#   repository = github_repository.ihc_lz_repo.name
#   enabled    = true
# }