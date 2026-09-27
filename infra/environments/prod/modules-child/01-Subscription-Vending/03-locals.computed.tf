
locals {

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


  group_roles_list = flatten([
    for sub in var.subscription_list : [
      for gra in sub.group_role_assignments : [
        for roleid in gra.roleid_list : {
          uid                 = "${sub.subscription_id}|${gra.security_group_name}|${roleid}"
          subscription_id     = sub.subscription_id
          security_group_name = gra.security_group_name
          roleid              = roleid
        }
      ]
    ]
  ])

  sp_roles_list = flatten([
    for sub in var.subscription_list : [
      for sra in sub.sp_role_assignments : [
        for roleid in sra.roleid_list : {
          uid             = "${sub.subscription_id}|${sra.sp_object_id}|${roleid}"
          subscription_id = sub.subscription_id
          sp_object_id    = sra.sp_object_id
          roleid          = roleid
        }
      ]
    ]
  ])

}

