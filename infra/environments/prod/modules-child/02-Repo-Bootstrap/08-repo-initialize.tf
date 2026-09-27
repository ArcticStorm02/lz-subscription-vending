



# Create Github Repo: 

 

# Add Gitignore 

resource "github_repository_file" "gitignore" {

  repository = github_repository.ihc_lz_repo.name

  file   = ".gitignore"
  branch = "main"

  commit_message = "Bootstrap repository structure"

  content = file("${path.module}/templates/gitignore.txt")

  overwrite_on_create = true

  depends_on = [ github_repository.ihc_lz_repo ]
}


resource "github_repository_file" "readme" {

  repository = github_repository.ihc_lz_repo.name

  file   = "README.md"
  branch = "main"

  commit_message = "Bootstrap repository structure"

  content = file("${path.module}/templates/README.txt")

  overwrite_on_create = true

  depends_on = [ github_repository.ihc_lz_repo ]
}
