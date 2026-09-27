# App Registration Object: 

resource "azuread_application" "tfl4_app_registration" {
  for_each = { for sub in local.subscription_list : sub.tfl4_id => sub }

  display_name = each.value.tfl4_name

  # Owner of this App Registration is TFL0
  # Here it means that TFL0  can view and edit this application registration
  # Assignment of groups as owners is not implemented here
  owners = [data.azuread_client_config.current.object_id]

  lifecycle {
    ignore_changes = [
      #oauth2_permission_scope_ids,
      api
    ]
  }
}

# Service Principal Object or Enterprise Application
resource "azuread_service_principal" "tfl4_service_principal" {
  for_each  = { for sub in local.subscription_list : sub.tfl4_id => sub }
  client_id = azuread_application.tfl4_app_registration[each.value.tfl4_id].client_id

  # Whether this service principal requires an app role assignment 
  # to a user or group before Azure AD will issue a user or access token to the application
  app_role_assignment_required = false

  # owners has the ability to manage all aspects of an enterprise application. 
  # TFL0 automation identity is the owner of the Enterprise Application.
  # Owner permissions allow management of the Service Principal and
  # assignment of additional owners if required.
  owners = [data.azuread_client_config.current.object_id]

  # Commented as : Terraform already knows the dependency on the application registration
  # depends_on = [
  #   azuread_application.tfl4_app_registration
  # ]
}

# Note: Federated Credential requires Repo ID, which will be created later by Github Bootstrap module. 
# Hence that will be skipped here. 
