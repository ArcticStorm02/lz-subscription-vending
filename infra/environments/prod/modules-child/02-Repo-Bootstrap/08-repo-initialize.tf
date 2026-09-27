
# Add Gitignore and Readme Files. 


# Bootstrap all Landing Zone repositories with the standard repository files.
#
# Files added:
#   - .gitignore : Standard Git ignore rules
#   - README.md  : Standard Landing Zone repository documentation
#
# Templates are maintained centrally under the module's templates directory
# and copied into each newly created repository.

resource "github_repository_file" "gitignore" {
  for_each            = { for repo in local.github_repo_list : repo.uid => repo }
  repository          = github_repository.landing_zone_repo[each.value.uid].name
  file                = ".gitignore"
  branch              = "main"
  commit_message      = "Bootstrap repository structure"
  content             = file("${path.module}/templates/gitignore.txt")
  overwrite_on_create = true
}


resource "github_repository_file" "readme" {
  for_each            = { for repo in local.github_repo_list : repo.uid => repo }
  repository          = github_repository.landing_zone_repo[each.value.uid].name
  file                = "README.md"
  branch              = "main"
  commit_message      = "Bootstrap repository structure"
  content             = file("${path.module}/templates/README.txt")
  overwrite_on_create = true
}

