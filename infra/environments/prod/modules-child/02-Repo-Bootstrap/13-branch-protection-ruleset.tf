
# Branch protection rules for all Landing Zone repositories.
#
# Applies to:
#   - main
#   - develop
#
# Protection includes:
#   - Prevent branch deletion
#   - Prevent force pushes
#   - Require pull requests before merging
#   - Require at least one approving review
#   - Dismiss stale approvals after new commits
#   - Require approval on the latest push
#   - Require all PR conversations to be resolved
#
# NOTE:
# Repository rulesets are available for public repositories on GitHub Free.
# Private repositories require GitHub Pro, Team, or Enterprise Cloud.
# Failing this causes: 403 Upgrade to GitHub Pro or make this repository public to enable this feature

resource "github_repository_ruleset" "main_and_develop" {
  for_each   = { for env in local.github_environment_list : env.uid => env }
  name       = "main-and-develop"
  repository = github_repository.landing_zone_repo[each.value.repo_uid].name

  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = [
        "refs/heads/main",
        "refs/heads/develop"
      ]
      exclude = []
    }
  }

  rules {
    # Prevent deletion of protected branches.
    deletion = true

    # Prevent force pushes to protected branches.
    non_fast_forward = true

    # Require pull requests before merging.
    pull_request {
      required_approving_review_count   = 1
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = false
      require_last_push_approval        = true
      required_review_thread_resolution = true
    }
  }

  depends_on = [
    github_branch.develop_branch
  ]
}
