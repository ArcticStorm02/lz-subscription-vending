# Create the standard development branch for all Landing Zone repositories.
#
# The develop branch is created from the initialized main branch after the
# repository bootstrap files have been committed.

resource "github_branch" "develop_branch" {
  for_each      = { for repo in local.github_repo_list : repo.uid => repo }
  repository    = github_repository.landing_zone_repo[each.value.uid].name
  branch        = "dev"
  source_branch = "main"
  depends_on = [
    github_repository_file.readme,
    github_repository_file.gitignore
  ]
}
