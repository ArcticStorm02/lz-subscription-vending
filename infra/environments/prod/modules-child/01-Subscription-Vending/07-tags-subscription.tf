
# Apply mandatory tags on TFL4 subscription

resource "azapi_update_resource" "subscription_tags" {
  for_each  = { for sub in local.subscription_list : sub.subscription_id => sub }
  type      = "Microsoft.Resources/tags@2021-04-01"
  name      = "default"
  parent_id = "/subscriptions/${data.azurerm_subscription.level1_subscription[each.value.subscription_id].subscription_id}"

  body = {
    properties = {
      tags = each.value.subscription_tags
    }
  }
}
# Optionally, Implement the feature to register :
# By default, the AzureRM provider automatically registers many resource providers 
# when Terraform starts, unless skip_provider_registration = true is configured 
# in the provider block.
# locals {
#   resource_providers = [
#     "Microsoft.Storage",
#     "Microsoft.KeyVault",
#     "Microsoft.Network",
#     "Microsoft.Insights",
#     "Microsoft.OperationalInsights"
#   ]
# }
# resource "azurerm_resource_provider_registration" "subscription_providers_reg" {
#   for_each = toset(local.resource_providers)
#   name     = each.value
# }
