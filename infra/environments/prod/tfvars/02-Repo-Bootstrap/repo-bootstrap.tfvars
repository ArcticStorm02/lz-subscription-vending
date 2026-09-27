# List of Github Repos to create

github_repo_list = [
  {
    org_name            = "ArcticStorm02"
    repo_name           = "ihc-lz-intg" # If empty string then auto-interpolated by module
    project_code        = "INTG" # AKA Landing Zone Code or Application Code, Max 5 Chars
    environments        = ["dev", "acc", "prod"]
    repo_url            = "https://github.com/ArcticStorm02/ihc-lz-intg.git" # Just for sake of searching

 
    group_role_assignments = [
      # {
      #   security_group_name = "Azure-Network-Admins"
      #   roleid_list = [
      #     # Built-in role: Reader
      #     "acdd72a7-3385-48ef-bd42-f606fba81ae7",
      #     # # Custom Role: ROLE-APIM-Integrations
      #     # "b24988ac-6180-42a0-ab88-20f7382dd24c"
      #   ]
      # }
    ]
 
  }
]



# github_repo_list = [
#   {
#     org_name            = "Royal-IHC-BV"
#     repo_name           = "ihc-lz-intg" # If empty string then auto-interpolated by module
#     project_code        = "INTG" # AKA Landing Zone Code or Application Code, Max 5 Chars
#     environments        = ["dev", "acc", "prod"]
#     repo_url            = "https://github.com/RoyalIHC-BV/ihc-lz-intg.git" # Just for sake of searching
    
 
#     group_role_assignments = [
#       # {
#       #   security_group_name = "Azure-Network-Admins"
#       #   roleid_list = [
#       #     # Built-in role: Reader
#       #     "acdd72a7-3385-48ef-bd42-f606fba81ae7",
#       #     # # Custom Role: ROLE-APIM-Integrations
#       #     # "b24988ac-6180-42a0-ab88-20f7382dd24c"
#       #   ]
#       # }
#     ]
 
#   }
# ]
