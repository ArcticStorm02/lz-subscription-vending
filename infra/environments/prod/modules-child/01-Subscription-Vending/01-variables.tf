
# @author: Rajesh Swarnkar

variable "subscription_list" {
  description = <<-EOD
  
  Defines list of All Azure subscriptions in current Tenant that needs to be onboarded.
  Each entry represents a single subscription and includes metadata
  required for secure, consistent landing zone subscription onboarding.

  Subscription must exist before running this.

  Each subscription entry requires:

    subscription_name  -> Human-readable display name of the subscription. Not used only for code-redability.
    subscription_id    -> GUID of the target subscription
    project_code       -> Short, unique identifier for the project (max 5 characters)
    environment_code   -> Deployment environment [dev | acc | prod]
    management_group_id -> ID of the Management group under which the Subscription will be associated 

    group_role_assignments -> AD synched or entra id Security groups that should have RBAC assigned at Subscription Scope
    sp_role_assignments -> RBAC for the app registrations and other SP
    create_sp_for_bdl -> Keep it false mostly, unless the App onwers need a Subscription-level SP 
    subscription_tags -> Set of MUST HAVE tags on subscriptions    

  Purpose:
    This variable enables automated and repeatable provisioning of landing zones,
    role assignment configurations at the subscription scope.

  EOD
  type = list(object({
    subscription_name   = string
    subscription_id     = string
    project_code        = string
    environment_code    = string # dev, acc, prod
    management_group_id = string # if null, then the default is Root Tenant Group

    subscription_tags = object({
      application_name    = string
      environment         = string
      owner               = string
      cost_center         = string
      business_unit       = string
      criticality         = string
      data_classification = string
    })

    # For all the roles here, the Scope is Subscription
    # Roles should be assigned to Service Principal (AppRegistration), Security Group, or Managed Identity
    # No roles shall be assigned to Individual User
    group_role_assignments = list(object({
      security_group_name = string
      roleid_list         = list(string) # This can be built in or custom role id (GUID). Custom Roles to be created by Platform facility.
    }))

    # https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal
    # azurerm_role_assignment requires the ObjectID of the Service Principal for principal_id
    # There are 3 ways to lookup the principal_id of Data Source: azuread_service_principal
    # Look up by application display name: display_name = "App Registration Display Name"
    # Look up by client ID: client_id = "00000000-0000-0000-0000-000000000000"
    # Look up by service principal object ID: object_id = "00000000-0000-0000-0000-000000000000"
    # I chose lookup by Object ID 
    # ObjectID can also be used for Managed Identity (User or System)
    # Thus it supports assigning RBAC roles to MI, App Registrations as both refereicing the SP Object ID
    sp_role_assignments = list(object({
      sp_object_id = string
      roleid_list  = list(string) # This can be built in or custom role id (GUID). Custom Roles to be created by Platform facility.
    }))

    federated_credentials = list(object({
      org_name                = string
      org_id                  = string
      repo_name               = string
      repo_id                 = string
      entity_type             = string
      github_environment_name = string
      credential_name         = string
      credential_desc         = string
      subject_identifier      = string
    }))

  }))

  # Validations: 

  validation {
    condition = alltrue([
      for subscription in var.subscription_list :
      length(subscription.project_code) <= 5
    ])
    error_message = "project_code must be 5 characters or fewer."
  }

  validation {
    condition = alltrue([
      for subscription in var.subscription_list :
      contains(["dev", "acc", "prod"], lower(subscription.environment_code))
    ])
    error_message = "environment_code must be one of: dev, acc, prod."
  }

  validation {
    condition = alltrue([
      for subscription in var.subscription_list :
      can(regex("^[0-9a-fA-F-]{36}$", trimspace(subscription.subscription_id)))
    ])
    error_message = "subscription_id must be a valid GUID consisting of 36 hex characters and hyphens."
  }
}
