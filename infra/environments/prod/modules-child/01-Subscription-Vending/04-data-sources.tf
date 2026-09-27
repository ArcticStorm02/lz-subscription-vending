data "azuread_client_config" "current" {}

## ----------------------------------------------------------------------
# This is to reference the Root Tenant Group
# Update the value   
data "azurerm_management_group" "root_tenant_group" {
  name = local.root_tenant_group_management_id 
}

## ----------------------------------------------------------------------
# Reference the Current subscription i.e. Lz-DevOps Prod 
# Passed from the .ini file
data "azurerm_subscription" "devops_subscription" {
}

## ----------------------------------------------------------------------
# Reference the SA in the DevOps Subscription
data "azurerm_storage_account" "devops_main_storage_account" {
  name                = local.devops_storage_account_name
  resource_group_name = local.devops_resource_group_name
}

## ----------------------------------------------------------------------
# Reference the Key Vault in the DevOps Subscription
# This will be used for storing the Certificates later for the TFL4 Service principal
# if required 

data "azurerm_key_vault" "devops_main_keyvault" {
  name                = local.devops_keyvault_name
  resource_group_name = local.devops_resource_group_name
}

## ----------------------------------------------------------------------

# This is to reference the all other management groups
# Update the value as per your customer's RTG  
data "azurerm_management_group" "management_groups" {
  for_each = {for sub in local.subscription_list : sub.subscription_id => sub }
  name = each.value.management_group_id
}

# The Target subscription which needs to be associated with the Management Group
# This is list of Subscription
data "azurerm_subscription" "level1_subscription" {
  for_each = {for sub in local.subscription_list : sub.subscription_id => sub }
  subscription_id = each.value.subscription_id
}

## ----------------------------------------------------------------------
# Data source to reference the specific Security (EntraID or AD-synched) Group where the
# Role assignments to be done on TFL4 Subscription
data "azuread_group" "entraid_group" {
  for_each = { for g in local.group_roles_list : g.uid => g }
  display_name = each.value.security_group_name
}


## ----------------------------------------------------------------------
# Reference the Private DNS Zones in Connectivity Subscription

data "azurerm_resource_group" "connectivity_rg_dns" {
name = "rg-connectivity-we-001"
provider = azurerm.LzConnectivity
}

## ----------------------------------------------------------------------
# Reference RG in Management Subscription

# rg-monitoring-mgmt-eu-01 > law-mgmt-weu-01
data "azurerm_resource_group" "management_rg_law" {
  name     = "rg-monitoring-mgmt-eu-01"
  provider = azurerm.LzManagement
}






# Data source to reference the Lz-Management Subscription
# This might be required for the case where TFL4 need to stream the Logs to the 
# Central Mgmt subscription
# data "azurerm_subscription" "management_subscription_01" {
#   subscription_id = "XXX" # Hardcoded, could use locals
# }

# # Data source to reference the Lz-SharedServices Subscription
# # This might be required for the case where TFL4 need to e.g. 
# # read Azure Compute Gallery Images from Shared Services subscription
# data "azurerm_subscription" "shared_service_subscription_01" {
#   subscription_id = "XXX" # Hardcoded, could use locals 
# }

