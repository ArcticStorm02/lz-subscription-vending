
# The target ALZ subscription that needs to be associated with provided management group

resource "azurerm_management_group_subscription_association" "mg_association" {
  for_each = { for sub in local.subscription_list : sub.subscription_id => sub }
  #  Format: /providers/Microsoft.Management/managementGroups/GUID
  management_group_id = data.azurerm_management_group.management_groups[each.value.subscription_id].id
  subscription_id     = data.azurerm_subscription.level1_subscription[each.value.subscription_id].id
  depends_on          = []
}
