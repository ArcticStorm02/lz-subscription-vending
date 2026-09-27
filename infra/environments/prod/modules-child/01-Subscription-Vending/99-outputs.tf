
# Count of Subscriptions
output "subscription_vend_count" {
  description = "Total number of subscriptions vended"
  value = length(local.subscription_list)
}

# Terraform State Storage Details which needs to be used in TFL4 Repositories 
# in .ini files 
output "terraform_state_storage_details" {

  description = "Terraform backend details for each vended subscription"
  value = [
    for alz in local.subscription_list : {

      subscription_name = alz.subscription_name
      subscription_id   = alz.subscription_id
      resource_group_name  = local.devops_resource_group_name
      storage_account_name = local.devops_storage_account_name
      container_name       = alz.tfl4_blob_container_name
      key = "tfl4-${lower(alz.project_code)}-${lower(alz.environment_code)}.tfstate"
    }
  ]
}
