

# For each entries in subscription_list, create a blob container in SA in DevOps Subscription
# Example: tfl4-intg-dev

resource "azurerm_storage_container" "tfl4_blobcontainer" {
  for_each              = { for sub in local.subscription_list : sub.uid => sub }
  name                  = each.value.tfl4_blob_container_name
  container_access_type = "private"
  storage_account_id    = data.azurerm_storage_account.devops_main_storage_account.id
}
