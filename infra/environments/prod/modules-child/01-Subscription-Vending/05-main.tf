# # Design elements: 
# # All the Subscriptions in Subscription List must be Unique and pre-exist
# # One Subscription is associated with exactly 1 TFL4, no more
# # 

# /*
# Move Subscription into correct Hierechy: azurerm_management_group_subscription_association.mgt_grp_sub_assoc[0]

# TFL4 SPs: 

# azuread_application.tfl4_application 
# azuread_service_principal.tfl4
# azuread_service_principal_password.tfl4_password  ## This is not desired 
# azurerm_key_vault_secret.tfl4_keyvault_secret  ## This is not desired 


# Shared Role assignments: Such as Mgmt, SharedService and DevOps SA and KeyVault:

# azurerm_role_assignment.tfl4_role_subscription["xxx"]
# azurerm_role_assignment.tfl4_role_management_subscription_id
# azurerm_role_assignment.tfl4_role_shared_service_subscription
# azurerm_role_assignment.tfl4_role_connectivity_subscription_dns

# azurerm_role_assignment.tfl4_role_devops_resourcegroup_state[]


# */