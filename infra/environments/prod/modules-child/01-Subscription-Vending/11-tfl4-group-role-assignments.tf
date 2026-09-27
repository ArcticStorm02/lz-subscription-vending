# Assign Roles to each security group mentioned
# See data-sources.tf and locals.tf
resource "azurerm_role_assignment" "group_role_assignment" {
  for_each           = { for role in local.group_roles_list : role.uid => role }
  scope              = data.azurerm_subscription.level1_subscription[each.value.subscription_id].id
  #role_definition_id = each.value.roleid
  role_definition_id = "/subscriptions/${each.value.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/${each.value.roleid}"
  principal_id       = data.azuread_group.entraid_group[each.value.uid].object_id
}
