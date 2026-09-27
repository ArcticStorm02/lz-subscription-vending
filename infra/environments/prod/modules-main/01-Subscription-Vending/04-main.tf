# Module Calls


# Subscription Vending

module "subscription_vending" {
  source            = "../../modules-child/01-Subscription-Vending"
  subscription_list = var.subscription_list

  providers = {
    azurerm                = azurerm,
    azurerm.LzConnectivity = azurerm.LzConnectivity
    azurerm.LzManagement   = azurerm.LzManagement
    # azurerm.LzSecurity     = azurerm.LzSecurity
  }

  depends_on = [
    # Any Dependencies for this module
  ]
}

 
