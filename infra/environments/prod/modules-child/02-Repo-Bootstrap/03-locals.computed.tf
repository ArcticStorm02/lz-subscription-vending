
locals {

 github_repo_list = flatten([

   for repo in var.github_repositories : {
     uid          = replace("${repo.repo_name}|${repo.project_code}", " ", "-") # Unique Iterator, Replace spaces with hyphens
     org_name     = repo.org_name
     repo_name    = repo.repo_name
     project_code = repo.project_code
     repo_url     = repo.repo_url
     environments = repo.environments
   }
 ])


  subscription_list = flatten([
    for sub in var.subscription_list : {
      
      uid               = replace("${sub.subscription_name}|${sub.subscription_id}", " ", "-") # Unique Iterator, Replace spaces with hyphens      
      subscription_name = sub.subscription_name
      subscription_id   = sub.subscription_id      
      project_code      = upper(sub.project_code)     # All CAPS
      environment_code  = title(sub.environment_code) # deV -> Dev
      management_group_id             = sub.management_group_id != "" ? sub.management_group_id : data.azurerm_management_group.root_tenant_group.id # Default to Root Tenanat Grou if Empty      
      subscription_tags               = sub.subscription_tags

      # SA RG in DevOps Subscription
      devops_resource_group_name = "${local.devops_resource_group_name}"
      # Storage Account Name
      devops_storage_account_name = "${local.devops_storage_account_name}"
      # Container for Subscription Vending  
      devops_blob_container_name = "${local.devops_blob_container_name}"

      # TFL4 App Registration and SP
      # e.g. TFL4-INTG-Dev|<subscription_id>
      tfl4_id   = "TFL4-${upper(sub.project_code)}-${title(sub.environment_code)}|${sub.subscription_id}"
      # TFL4 Name must be unique in KV. This forces the Porject Code and Env to be unique in subscription list 
      # e.g TFL4 INTG Dev
      tfl4_name = "TFL4 ${upper(sub.project_code)} ${title(sub.environment_code)}"
      # Create additional blob container for Level 1
      
      # This where each TFL4 project store the tfstate file. e.g. tfl4-intg-dev
      tfl4_blob_container_name = "tfl4-${lower(sub.project_code)}-${lower(sub.environment_code)}"
      
      # Instead of Secret, user Federated Credentials
      # tfl4_kv_secretname = "TFL4-clientsecret-${upper(sub.project_code)}-${title(sub.environment_code)}" # Must be unique in KV

    }
  ])




}



#  environment_variables = merge([

#     for env in [
#       "Lz-INTG-Dev",
#       "Lz-INTG-Acc",
#       "Lz-INTG-Prod"
#     ] : {

#       "${env}-ARM_CLIENT_ID" = {
#         environment = env
#         name        = "ARM_CLIENT_ID"
#         value       = "<Update This Value>"
#       }

#       "${env}-ARM_SUBSCRIPTION_ID" = {
#         environment = env
#         name        = "ARM_SUBSCRIPTION_ID"
#         value       = "<Update This Value>"
#       }

#       "${env}-ARM_TENANT_ID" = {
#         environment = env
#         name        = "ARM_TENANT_ID"
#         value       = "<Update This Value>"
#       }
#     }

#   ]...)