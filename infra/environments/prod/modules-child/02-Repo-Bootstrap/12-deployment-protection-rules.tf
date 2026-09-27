

# Approval Gate: 

data "github_user" "current" {
  username = "rs-rihc"
}

/*
422 Failed to create the environment protection rule. 
Please ensure the billing plan supports the required reviewers protection rule.
*/

/*

resource "github_repository_environment" "dev" {
  repository  = github_repository.ihc_lz_repo.name
  environment = "Lz-INTG-Dev"

  wait_timer = 15

  can_admins_bypass   = true
  prevent_self_review = false # true

  reviewers {
    users = [
      data.github_user.current.id
    ]
  }
}

resource "github_repository_environment" "acc" {
  repository  = github_repository.ihc_lz_repo.name
  environment = "Lz-INTG-Acc"

  wait_timer = 15

  can_admins_bypass   = true
  prevent_self_review = false # true

  reviewers {
    users = [
      data.github_user.current.id
    ]
  }
}

resource "github_repository_environment" "prod" {
  repository  = github_repository.ihc_lz_repo.name
  environment = "Lz-INTG-Prod"

  wait_timer = 15

  can_admins_bypass   = true
  prevent_self_review = false # true

  reviewers {
    users = [
      data.github_user.current.id
    ]
  }
}

*/ 





/*
422 Failed to create the environment protection rule. 
Please ensure the billing plan supports the required reviewers protection rule.
*/

/*

resource "github_repository_environment" "dev" {
  repository  = github_repository.ihc_lz_repo.name
  environment = "Lz-INTG-Dev"

  wait_timer = 15

  can_admins_bypass   = true
  prevent_self_review = false # true

  reviewers {
    users = [
      data.github_user.current.id
    ]
  }
}

resource "github_repository_environment" "acc" {
  repository  = github_repository.ihc_lz_repo.name
  environment = "Lz-INTG-Acc"

  wait_timer = 15

  can_admins_bypass   = true
  prevent_self_review = false # true

  reviewers {
    users = [
      data.github_user.current.id
    ]
  }
}

resource "github_repository_environment" "prod" {
  repository  = github_repository.ihc_lz_repo.name
  environment = "Lz-INTG-Prod"

  wait_timer = 15

  can_admins_bypass   = true
  prevent_self_review = false # true

  reviewers {
    users = [
      data.github_user.current.id
    ]
  }
}

*/ 