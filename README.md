# About: ihc-lz-subscription-vending

This is a Infrastructure-as-Code (Terraform)  Github repository. 

> Note: Terraform Infra Github repositories have naming pattern: `ihc-lz-<Landing Zone Short Code Name>`. 



## Subscription Vending and Bootstrap processes: 

Subscription vending is automation of creation of subscriptions. Also, Terraform requires additional pre-requisites such as Service Principal, Federated Credential. 

Following is the typical actions performed by this automation. 


| Phase | Steps | Principal for authetication and deployment |
|---------|---------|---------|
| Subscription Creation | Create Subscriptions from Azure Portal for new app landing zone (per environment) | Manual Step |
| Subscription Vending | Associate the subscription with Management Group (Online, Corp) | TFL0 |
| Subscription Vending | Apply mandatory tags on subscription | TFL0 |
| Subscription Vending | Register Resource Providers on TFL4 subscription | TFL0 |
| Subscription Vending | Subscription Level Role Management - Assign Roles to Security Groups | TFL0 |
| Subscription Vending | Subscription Level Role Management - Assign Roles to Service Principals | TFL0 |
| Subscription Vending |  | TFL0 |
| Terraform Pre-requisite Bootstrap | Create TFL4 App Registration (Service Principal) - (per environment) | TFL0 |
| Terraform Pre-requisite Bootstrap | Assign Owner role to TFL4 Service Principal on the ALZ Subscription | TFL0 |
| Terraform Pre-requisite Bootstrap | Assign Roles to TFL4 Service Principal on DevOps and Other Platform Areas | TFL0 |
| Terraform Pre-requisite Bootstrap | Create Blob Container in Storage Account in Lz-DevOps Subscription | TFL0 |
| Github Repo Bootstrap | Create Github Repo and Output Org Name and ID, Repo Name and ID (To be used by Federated credential Bootstrap). | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Initialize gitignore and readme files | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Create Branches | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Create Branch Protection Ruleset for main and develop | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Assign Default Groups | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Assign Team permissions: RIHC-Azure-IaC-DevOps-Admins, RIHC-Azure-IaC-DevOps-Developers | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Create Environments and Evironment Variables for Terraform Login (ARM_CLIENT_ID, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID) | No TFL / Github App + RSA PRIVATE KEY |
| Github Repo Bootstrap | Create Deployment Protection Rule (Approval Gates) | No TFL / Github App + RSA PRIVATE KEY |
| Federated credential Bootstrap | Read Output values for the Federated credential for Github Actions. | TFL0 |
| Federated credential Bootstrap | Federated credential for Github Actions: Configure Identity Federation in TFL4 SP for Environment Name | TFL0 |
| Platform Governance Resources | Deploy Azure Policies and Custom Roles* | TFL0 or Separate Platform SP |
| Common Resources | Deploy Online or Corp 

Note: 
> Separate Platform facility should exist to manage common platform concerns such as CRUD Management Groups, Mg Policy, Mg Custom Roles etc. 

> * Note 1: A Separate platform facility should be planned to create Subscription Level Custom Role Definitions and Policy Definitions and Assignments (EPAC). However, optionally this can be done using TFL0. Many of the common concerns like for example Deploy Alert Rules, Enable Diagnostic settings, Enable Audit Logging, Enable Defender etc can be done by Azure Policies instead of Terraform (Monolithic).

> Note 2: Currently, the Platform Zones are being built by RapidCircle. How the common concerns are being handled in RC code is important for us to decide how to bring those into the Vending automation and Terraform Levels highly depend on that. Since Handover is still not yet done, and the teams (MyIHC, INTG, SPRT) have active demands, I am proceeding with `TFL0` for the Vending automation.   



# Identities for automation: 

| Phase | Principal for authetication and deployment |
|---------|---------|
| Subscription Creation | TFL0 |
| Subscription Vending | TFL0 |
| Terraform Pre-requisite Bootstrap | TFL0 |
| Github Repo Bootstrap | No TFL / Github App + RSA PRIVATE KEY |
| Federated credential Bootstrap | TFL0 |
| Platform Governance Resources | TFL0 or Separate Platform SP |
| Common Resources | TFL0 or Separate Platform SP |
| IaC Development | TFL4 |



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
