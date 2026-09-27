
# Optionally, Implement the feature to register :
# By default, the AzureRM provider automatically registers many resource providers 
# when Terraform starts, unless skip_provider_registration = true is configured 
# in the provider block.

# resource "azurerm_resource_provider_registration" "subscription_providers_reg" {
#   for_each = toset([
#     "Microsoft.Network",
#     "Microsoft.Storage",
#     "Microsoft.KeyVault",
#     "Microsoft.ManagedIdentity",
#     "Microsoft.OperationalInsights"
#   ])
#   name = each.value
# }