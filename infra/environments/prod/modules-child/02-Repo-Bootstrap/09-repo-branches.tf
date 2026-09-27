

# Approval Gate: 

data "github_user" "current" {
  username = "rs-rihc"
}




resource "github_branch" "develop_branch" {
  repository    = github_repository.ihc_lz_repo.name
  branch        = "develop"
  source_branch = "main"

  depends_on = [
    github_repository.ihc_lz_repo,
    github_repository_environment.environments,
    github_repository_file.readme
  ]
}

# Not creating feature branch
# resource "github_branch" "feature_branch" {
#   repository    = github_repository.ihc_lz_repo.name
#   branch        = "feature-InitialSetup"
#   source_branch = "develop"
#   depends_on = [ github_branch.develop_branch ]
# }
