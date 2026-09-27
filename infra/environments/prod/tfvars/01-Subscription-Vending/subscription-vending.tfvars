# List of Application Zone Landing Zone Subscriptions: 

subscription_list = [
  {
    subscription_name   = "payg-rswarnka-02"
    subscription_id     = "7fda6ba4-c415-4f50-a242-8db2d3a3cd76"
    project_code        = "INTG"
    environment_code    = "dev"
    management_group_id = "mg-online" # # if null, then the default is Root Tenant Group

    subscription_tags = {
      application_name    = "APIM Integrations"
      environment         = "Development"
      owner               = "a.visser@royalihc.com"
      cost_center         = "PFM7-HQMQ-PJA-PGB"
      business_unit       = "CD ICT"
      criticality         = "Business Critical"
      data_classification = "Internal"
    }

    group_role_assignments = [
      {
        security_group_name = "Azure-Network-Admins"
        roleid_list = [
          # Built-in role: Reader
          "acdd72a7-3385-48ef-bd42-f606fba81ae7",
          # # Custom Role: ROLE-APIM-Integrations
          # "b24988ac-6180-42a0-ab88-20f7382dd24c"
        ]
      }
    ]
    sp_role_assignments = [
      {
        # ObjectID of Enterprise App : TFSP0
        sp_object_id = "ed364440-56c5-4b20-8c78-9f4a41ad8059"
        roleid_list = [
          # Built-in role: Reader
          "acdd72a7-3385-48ef-bd42-f606fba81ae7",
          # # Custom Role: ROLE-APIM-Integrations
          # "b24988ac-6180-42a0-ab88-20f7382dd24c"
        ]
      }
    ]

    # Keep this list empty in first deployment. 
    # After the Github Repo bootstrap is done,
    # populate this list with the 2 federated credentials per env 
    # for the build and release workflows.
    federated_credentials = [
      # 2 Fed Cred for Build and Release  
      {
        org_name                = "Royal-IHC-BV"                 # Does not changes for Royal-IHC-BV
        org_id                  = "73669067"                     # Does not changes for Royal-IHC-BV
        repo_name               = "ihc-lz-intg"                  # Populate this after running Repo-Vending Module
        repo_id                 = "1374228735"                   # To find the repo ID, view page source and search for : octolytics-dimension-repository_id
        entity_type             = "Environment"                  # Supported values: "Environment", "Branch", "PullRequest", "Tag"
        github_environment_name = "Lz-INTG-Dev-Build"            # IMP. Populate this after running Repo-Vending Module
        credential_name         = "OIDC-Environment-Build-Lz-INTG-Dev" # Format: OIDC-<Entity Type>-<lz-code>
        credential_desc         = "Environment based Token Issuance for Github Action Repo linked to Subscription Lz-INTG-Dev"
        subject_identifier      = "" # if Empty String, then Child module will populate this, else overridden. 
      },
      {
        org_name                = "Royal-IHC-BV"                 # Does not changes for Royal-IHC-BV
        org_id                  = "73669067"                     # Does not changes for Royal-IHC-BV
        repo_name               = "ihc-lz-intg"                  # Populate this after running Repo-Vending Module
        repo_id                 = "1374228735"                   # To find the repo ID, view page source and search for : octolytics-dimension-repository_id
        entity_type             = "Environment"                  # Supported values: "Environment", "Branch", "PullRequest", "Tag"
        github_environment_name = "Lz-INTG-Dev-Release"                # IMP. Populate this after running Repo-Vending Module
        credential_name         = "OIDC-Environment-Release-Lz-INTG-Dev" # Format: OIDC-<Entity Type>-<lz-code>
        credential_desc         = "Environment based Token Issuance for Github Action Repo linked to Subscription Lz-INTG-Dev"
        subject_identifier      = "" # if Empty String, then Child module will populate this, else overridden. 
      }
    ]
  }
]


# subscription_list = [
#   {
#     subscription_name   = "Lz-INTG Dev"
#     subscription_id     = "1becb114-a061-4ebe-b358-eeafa91e1215"
#     project_code        = "INTG"
#     environment_code    = "dev"
#     management_group_id = "mg-online" # # if null, then the default is Root Tenant Group

#     subscription_tags = {
#       application_name    = "APIM Integrations"
#       environment         = "Development"
#       owner               = "a.visser@royalihc.com"
#       cost_center         = "PFM7-HQMQ-PJA-PGB"
#       business_unit       = "CD ICT"
#       criticality         = "Business Critical"
#       data_classification = "Internal"
#     }

#     group_role_assignments = [
#       {
#         security_group_name = "Azure-Network-Admins"
#         roleid_list = [
#           # Built-in role: Reader
#           "acdd72a7-3385-48ef-bd42-f606fba81ae7",
#           # # Custom Role: ROLE-APIM-Integrations
#           # "b24988ac-6180-42a0-ab88-20f7382dd24c"
#         ]
#       }
#     ]
#     sp_role_assignments = [
#       {
#         # ObjectID of Enterprise App : TFSP0
#         sp_object_id = "ed364440-56c5-4b20-8c78-9f4a41ad8059"
#         roleid_list = [
#           # Built-in role: Reader
#           "acdd72a7-3385-48ef-bd42-f606fba81ae7",
#           # # Custom Role: ROLE-APIM-Integrations
#           # "b24988ac-6180-42a0-ab88-20f7382dd24c"
#         ]
#       }
#     ]

#     # Keep this list empty in first deployment. 
#     # After the Github Repo bootstrap is done,
#     # populate this list with the 2 federated credentials per env 
#     # for the build and release workflows.
#     federated_credentials = [
#       # 2 Fed Cred for Build and Release  
#       {
#         org_name                = "Royal-IHC-BV"                 # Does not changes for Royal-IHC-BV
#         org_id                  = "73669067"                     # Does not changes for Royal-IHC-BV
#         repo_name               = "ihc-lz-intg"                  # Populate this after running Repo-Vending Module
#         repo_id                 = "1374228735"                   # To find the repo ID, view page source and search for : octolytics-dimension-repository_id
#         entity_type             = "Environment"                  # Supported values: "Environment", "Branch", "PullRequest", "Tag"
#         github_environment_name = "Lz-INTG-Dev-Build"            # IMP. Populate this after running Repo-Vending Module
#         credential_name         = "OIDC-Environment-Build-Lz-INTG-Dev" # Format: OIDC-<Entity Type>-<lz-code>
#         credential_desc         = "Environment based Token Issuance for Github Action Repo linked to Subscription Lz-INTG-Dev"
#         subject_identifier      = "" # if Empty String, then Child module will populate this, else overridden. 
#       },
#       {
#         org_name                = "Royal-IHC-BV"                 # Does not changes for Royal-IHC-BV
#         org_id                  = "73669067"                     # Does not changes for Royal-IHC-BV
#         repo_name               = "ihc-lz-intg"                  # Populate this after running Repo-Vending Module
#         repo_id                 = "1374228735"                   # To find the repo ID, view page source and search for : octolytics-dimension-repository_id
#         entity_type             = "Environment"                  # Supported values: "Environment", "Branch", "PullRequest", "Tag"
#         github_environment_name = "Lz-INTG-Dev-Release"                # IMP. Populate this after running Repo-Vending Module
#         credential_name         = "OIDC-Environment-Release-Lz-INTG-Dev" # Format: OIDC-<Entity Type>-<lz-code>
#         credential_desc         = "Environment based Token Issuance for Github Action Repo linked to Subscription Lz-INTG-Dev"
#         subject_identifier      = "" # if Empty String, then Child module will populate this, else overridden. 
#       }
#     ]
#   }
# ]
