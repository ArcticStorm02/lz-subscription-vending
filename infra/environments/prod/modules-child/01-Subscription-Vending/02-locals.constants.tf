# Locals for CONSTANT values
locals {

  # Org Code is ALWAYS "ihc"
  org_code = "ihc"

  # # By Default, all resources for state store will be in West Europe
  default_primary_region = "westeurope"

  # Naming: 
  rg_resource_shortcode = "rsg"

  env_code_map = {
    dev  = "d"
    acc  = "a"
    prod = "p"
  }

  # Magic Values / Constants: 

  # UUID of the Root Management Group
  # root_tenant_group_management_id = "20ceeb2a-a900-498e-92f1-9ae11e78295f"
  root_tenant_group_management_id = "061bc4a2-a11e-446a-ad8e-c717e269679d"

  ## Decision: We use a central storage account for all the Terraform state management
  ## The state files and the blob container names must be per subscription environment. 
  devops_resource_group_name  = "ihc-alzd-p-weu-rsg-devops"
  devops_kv_resource_group_name = "ihc-alzd-p-weu-rsg-devops"

  devops_storage_account_name = "ihcalzdpweudevopstf"
  devops_blob_container_name  = "tfl0-subscription-vending"

  devops_keyvault_name          = "ihc-alzd-p-weu-kv-devops"
  

}

