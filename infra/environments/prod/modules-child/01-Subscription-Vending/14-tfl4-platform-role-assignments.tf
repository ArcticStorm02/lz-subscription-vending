
##----------------------------------------------------------------------------------------
#### Roles section for Subscriptions which are required to be accessed by TFL4  
##----------------------------------------------------------------------------------------
## In many cases the TFL4, need to access some other subscriptions and resource groups in other subscriptions
## to cater such cases this subsequent part of this file is dedicated for the share role 
## Please note this section will expand as new requirement come along for the shared stuffs such as 
## automation, networking, platform access, monitoring, logging, Compure Image Gallery, DNS Zones etc. 

/* 
# DevOps Subscription Role Assignments : 
Storage Blob Data Contributor: 
Key Vault Secrets Officer
Key Vault Certificates Officer
Key Vault Reader


# Connectivity Subscription Role Assignments: 
Private DNS Zone Contributor 


# Management Subscription Role Assignments: 
Log Analytics Contributor
Monitoring Contributor
Compure Image Gallery Contributor

*/

## -----------------------------------------------------------------------------
# DevOps Subscription Role Assignments : 

# Storage Account Contributor on SA in DevOps Subscription
resource "azurerm_role_assignment" "tfl4_sa_blob_data_contributor" {
  for_each             = { for sub in local.subscription_list : sub.uid => sub }
  scope                = data.azurerm_storage_account.devops_main_storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id
}

# Key Vault Certificates Officer on KV in DevOps Subscription
resource "azurerm_role_assignment" "tfl4_kv_certificates_officer" {
  for_each             = { for sub in local.subscription_list : sub.uid => sub }
  scope                = data.azurerm_key_vault.devops_main_keyvault.id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id
}
## Key Vault Reader on KV in DevOps Subscription
resource "azurerm_role_assignment" "tfl4_kv_reader" {
  for_each             = { for sub in local.subscription_list : sub.uid => sub }
  scope                = data.azurerm_key_vault.devops_main_keyvault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id
}

## Key Vault Secrets Officer on KV in DevOps Subscription
resource "azurerm_role_assignment" "tfl4_kv_secrets_officer" {
  for_each             = { for sub in local.subscription_list : sub.uid => sub }
  scope                = data.azurerm_key_vault.devops_main_keyvault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id
}

## -----------------------------------------------------------------------------
# Connectivity Subscription Role Assignments: 

## Private DNS Zone Contributor on Private DNS Zones in Connectivity Subscription

resource "azurerm_role_assignment" "tfl4_private_dns_zone_contributor" {
  for_each             = { for sub in local.subscription_list : sub.uid => sub }
  scope                = data.azurerm_resource_group.connectivity_rg_dns.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id
}


## -----------------------------------------------------------------------------
# Management Subscription Role Assignments: 

# As of now I am not implementing this. 
# DO this when Platform is ready 

## Log Analytics Contributor on Management Subscription
resource "azurerm_role_assignment" "tfl4_log_analytics_contributor" {
  for_each             = { for sub in local.subscription_list : sub.uid => sub }
  scope                = data.azurerm_resource_group.management_rg_law.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id
}

