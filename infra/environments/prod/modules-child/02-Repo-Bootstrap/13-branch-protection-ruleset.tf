

# Note that branch protection rules requires: Github Pro, Team, Enterprise or Public Repo
# Repository Rulesets are not available for: Personal Account + Private Repository + Free Plan


#  403 Upgrade to GitHub Pro or make this repository public to enable this feature. []

# Commented for now
/* 
resource "github_repository_ruleset" "main_and_develop" {

  name        = "main-and-develop"
  repository  = github_repository.ihc_lz_repo.name

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

    #
    # Restrict deletions
    #
    deletion = true

    #
    # Block force push
    #
    non_fast_forward = true

    #
    # Require PR before merge
    #
    pull_request {

      required_approving_review_count = 1

      dismiss_stale_reviews_on_push = true

      require_code_owner_review = false

      require_last_push_approval = true

      required_review_thread_resolution = true
    }

    #
    # Code scanning
    #
    required_code_scanning {

      required_code_scanning_tool {

        tool = "CodeQL"

        alerts_threshold = "errors"

        security_alerts_threshold = "high_or_higher"
      }

      required_code_scanning_tool {

        tool = "checkov"

        alerts_threshold = "errors"

        security_alerts_threshold = "high_or_higher"
      }
    }
  }

  depends_on = [ github_branch.develop_branch ]
}


*/ 