# Module Calls

# Create Github Repo and Output Org Name and ID, Repo Name and ID (To be used by Federated credential Bootstrap).
# Initialize gitignore and readme files
# Create Branches
# Create Branch Protection Ruleset for main and develop
# Assign Default Groups
# Assign Team permissions: RIHC-Azure-IaC-DevOps-Admins, RIHC-Azure-IaC-DevOps-Developers
# Create Environments and Evironment Variables for Terraform Login (ARM_CLIENT_ID, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID)
# Create Deployment Protection Rule (Approval Gates)


# Repo Bootstrap
  
 module "repo_bootstrap" {
  source = "../../modules-child/02-Repo-Bootstrap"
  github_repo_list = var.github_repo_list

  providers = {
    github = github
  }

  depends_on = [
    # Any Dependencies for this module
  ]
}
