 
# Outputs

# Count of Subscriptions Vended
output "subscription_vend_count" {
  description = "Total number of subscriptions vended"
  value       = module.subscription_vending.subscription_vend_count
}

# Terraform Backend Details for TFL4 Repositories
output "terraform_state_storage_details" {
  description = "Terraform backend details for each vended subscription"
  value       = module.subscription_vending.terraform_state_storage_details
}