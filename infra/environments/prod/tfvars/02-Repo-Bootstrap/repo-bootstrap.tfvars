# The Github Organization Details
# (Invoke-RestMethod "https://api.github.com/orgs/MYCOOLORG").id
org_details = {
  org_name = "ArcticStorm02"
  org_id   = "123456"
}

# The Github App must be created and installed with
# appropiate permissions
github_app_details = {
  app_id          = 5094683
  installation_id = 165387746
}

# List of Github Repos to be bootstrapped

github_repositories = [
  {
    project_code     = "XYZW"        # AKA Landing Zone Code or Application Code, Max 5 Chars
    repo_name        = "ihc-lz-intg" # If empty string then auto-interpolated by module
    repo_description = "IHC Repository for INTG Landing Zone"
    repo_url         = "https://github.com/ArcticStorm02/ihc-lz-intg.git" # Just for sake of searching
    # Currently Creation of Secret 
    environments = [
      {
        environment_name = "Lz-INTG-Dev-Build"
        ARM_Environment_Vars = {
          ARM_CLIENT_ID       = "your-client-id",
          ARM_SUBSCRIPTION_ID = "your-subscription-id",
          ARM_TENANT_ID       = "your-tenant-id"
        }
        deployment_protection_rules = [] # If empty list then no protection rules are applied
      },
      {
        environment_name = "Lz-INTG-Dev-Release"
        ARM_Environment_Vars = {
          ARM_CLIENT_ID       = "your-client-id",
          ARM_SUBSCRIPTION_ID = "your-subscription-id",
          ARM_TENANT_ID       = "your-tenant-id"
        }
        deployment_protection_rules = [
          {
            name = "Lz-INTG-Dev-Release-DPR"
            required_reviewers_usernames = [
              "rs-rihc"
            ]
            wait_timer = 15 # number between 1 and 43200, If null then box is Unchecked
          }
        ]
      },
      {
        environment_name = "Lz-INTG-Prod-Build"
        ARM_Environment_Vars = {
          ARM_CLIENT_ID       = "your-client-id",
          ARM_SUBSCRIPTION_ID = "your-subscription-id",
          ARM_TENANT_ID       = "your-tenant-id"
        }
        deployment_protection_rules = []
      },
      {
        environment_name = "Lz-INTG-Prod-Release"
        ARM_Environment_Vars = {
          ARM_CLIENT_ID       = "your-client-id",
          ARM_SUBSCRIPTION_ID = "your-subscription-id",
          ARM_TENANT_ID       = "your-tenant-id"
        }
        deployment_protection_rules = [
          {
            name = "Lz-INTG-Prod-Release-DPR"
            required_reviewers_usernames = [
              "rs-rihc"
            ]
            wait_timer = 15 # number between 1 and 43200, If null then box is Unchecked
          }
        ]
      },
    ]

  }
]
