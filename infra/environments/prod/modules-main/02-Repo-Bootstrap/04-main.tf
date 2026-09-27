
# Repo Bootstrap
module "repo_bootstrap" {
  source              = "../../modules-child/02-Repo-Bootstrap"
  github_repositories = var.github_repositories
  providers = {
    github = github
  }
  depends_on = [] # Any Dependencies for this module
}
