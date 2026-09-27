# About: `ihc-lz-XYZW`

This is a Infrastructure-as-Code (Terraform)  Github repository. 

> Note: Terraform Infra Github repositories have naming pattern: `ihc-lz-<Landing Zone Short Code Name>`. 


# Miscellaneous:
## Infra automation key design elements: 

1. The landing zone repository is for IaC (Terraform) and the repository should reflects a Landing zone infra code. 
2. The landing zone repository  should be organized to support a clean separation of environments and reusable infrastructure components. 
3. Terraform state is stored in an Azure Storage Account and container. 
4. Each environment maintains its own isolated backend tfstate file to prevent cross-environmental interference and to enforce least privilege access controls.
5. Repository must not contains any hard-coded secrets and secrets should be scanned. 
6. GitHub Actions authenticates to Azure via OIDC federation using workload identities. This eliminates the need for long-lived credentials such as client secrets and enables short-lived token-based authentication.
7. Create separate workflow file per environment and isolated build/release workflows.
8. Build pipeline should be triggered on commit and can as many times as needed. 
9. A release is always intentional and Release pipelines are NOT automatic. This is to avoid any inadvertent/undesired relases getting created.
10. Build workflow to include: Checkout, Azure login via OIDC, Terraform Setup, Terraform Init, Terraform format (optional), Terraform validate (optional), Checkov Scan, Terraform Plan, Create and Upload Artifacts 
11. Release workflow to include: Checkout, Azure login via OIDC, Terraform Setup, Terraform Init, Terraform format (optional), Terraform validate (optional), Checkov Scan, Terraform Plan, Create and Upload Artifacts, In Apply Another Job: Download Artifact, Generate Plan, Apply 
12. Branching Strategy: Do not confuse the Branching strategy (main, dev, feature branches) with the Landing Zone Environments. Here, we follow isolation and separation of concern principle. All the work that gets done in Github is only for Code quality and Code security concern. We do not mix and complicate Github level concerns with the Terraform workflow or Infra-as-Code. This achieves isolation and independence and faster development. 
13. For injection of secrets into worklflow use Github Secrets. 
14. There is no separate pipeline required for drift detection. The Terraform build pipeline does this job every time a commit is made. Its imperative that IaC engineer fixes those frequently before making a release. 
15. The Application repositories shall not deploy any additional infra services. Those should be done through Infra (IaC) pipelines only. Application pipelines can reference the existing deployed infra using Data sources construct in Terraform. This promotes separation of concerns. 
16. Platform or Cloud Platform Devops Team owns and manages all IaC (Terraform code) changes in the infra repositories, and approves, executes & troubleshoots all infrastructure releases. 
