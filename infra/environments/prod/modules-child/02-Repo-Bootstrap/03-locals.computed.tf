


locals {

  environment_variables = merge([

    for env in [
      "Lz-INTG-Dev",
      "Lz-INTG-Acc",
      "Lz-INTG-Prod"
    ] : {

      "${env}-ARM_CLIENT_ID" = {
        environment = env
        name        = "ARM_CLIENT_ID"
        value       = "<Update This Value>"
      }

      "${env}-ARM_SUBSCRIPTION_ID" = {
        environment = env
        name        = "ARM_SUBSCRIPTION_ID"
        value       = "<Update This Value>"
      }

      "${env}-ARM_TENANT_ID" = {
        environment = env
        name        = "ARM_TENANT_ID"
        value       = "<Update This Value>"
      }
    }

  ]...)
}
