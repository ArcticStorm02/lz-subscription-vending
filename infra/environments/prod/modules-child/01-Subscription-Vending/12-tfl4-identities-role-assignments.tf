# Assign Roles to the objectID of Service Principal Of {App Registration, Managed Identity etc.}
# See data-sources.tf and locals.tf
# Scope by default is the TFL4 subscription 
resource "azurerm_role_assignment" "sp_role_assignment" {
  for_each           = { for role in local.sp_roles_list : role.uid => role }
  scope              = data.azurerm_subscription.level1_subscription[each.value.subscription_id].id
  #role_definition_id = each.value.roleid
  role_definition_id = "/subscriptions/${each.value.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/${each.value.roleid}"
  principal_id       = each.value.sp_object_id
}


# Very common mistake (worth calling out) below are wrong GUIDs
# Using Application (Client) ID
# Using Resource ID of UAMI
# Using Display Name
# Correct GUIDs are: 
# ```
# | Identity Type    | What `sp_object_id` must be       |
# | ---------------- | --------------------------------- |
# | App Registration | Service Principal **Object ID**   |
# | UAMI             | Managed Identity **Principal ID** |
# | SAMI             | Managed Identity **Principal ID** |
# ```
 
