 
# Outputs

# Count of Repositories bootstrapped
output "repo_bootstrap_count" {
  description = "Total number of repositories bootstrapped"
  value       = module.repo_bootstrap.repo_bootstrap_count
}

# Instructions to follow after bootstrapping the repository
output "post_bootstrap_instructions" {
  description = "Instructions to follow after bootstrapping the repository"
  value       = "Set the Variables in the environment for Terraform Login (ARM_CLIENT_ID, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID)."
}

