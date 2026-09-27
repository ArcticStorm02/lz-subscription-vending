

/* TFL4 role assignments: 
TFL4 SP will require following roles: 

Own Zone: 
1. Owner on the ALZ Subscription 

Platform Zones: 
2. Storage Blob Data Contributor on DevOps RG in DevOps Subscription
3. Key Vault Certificates Officer on specific RG in DevOps Subscription
4. Central Log analytics workspace in Management Subscription
5. Update records in DNS Zones in Connectivity Subscription
6. Any more ? 
*/

# Owner on Subscription (Level1)
# TFL4 should be able to do perform any action inside its own subscription only.
# it eliminates endless troubleshooting later when a deployment suddenly requires permissions that the TFL4 SP does not have. e.g Key Vault access policy changes. 
resource "azurerm_role_assignment" "tfl4_owner_subscription" {
  for_each             = { for sub in local.subscription_list : sub.tfl4_id => sub }
  scope                = data.azurerm_subscription.level1_subscription[each.value.subscription_id].id
  role_definition_name = "Owner" # Owner role 
  principal_id         = azuread_service_principal.tfl4_service_principal[each.value.tfl4_id].object_id

}
