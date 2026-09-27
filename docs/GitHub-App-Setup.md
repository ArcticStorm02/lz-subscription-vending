# GitHub App Setup

This document describes how to create and configure a GitHub App for Terraform authentication, install it on the target GitHub organization, and obtain the required **App ID**, **Installation ID**, and **Private Key**.

GitHub Apps provide an application identity with explicitly defined permissions and can be used by Terraform without using a personal access token. GitHub recommends granting only the minimum permissions required by the application.

## 1. Create the GitHub App

Navigate to:

**GitHub Organization → Settings → Developer settings → GitHub Apps → New GitHub App**

For example:

```text
Organization: ArcticStorm02
App name: rs-repo-bootstrap
```

Configure the basic information:

| Setting                                 | Value                              |
| --------------------------------------- | ---------------------------------- |
| GitHub App name                         | `rs-repo-bootstrap`                |
| Homepage URL                            | `https://github.com/ArcticStorm02` |
| Webhooks                                | Disabled, unless required          |
| Where can this GitHub App be installed? | Only on this account               |

GitHub Apps can be registered under an organization that you own or where you have GitHub App management permissions.

## 2. Configure App Permissions

Under **Permissions**, grant only the permissions required by the Terraform GitHub provider and the resources managed by this module.

For repository management, review the required **Repository permissions** and **Organization permissions** based on the Terraform resources being created.

For example, if the application manages repositories, environments, and repository settings, the required permissions may include repository administration-related permissions.

> **Important:** Do not blindly grant `Read & write` to every permission. GitHub Apps should use the minimum permissions necessary.

After changing permissions on an already-installed App, the installation must approve the updated permissions before they take effect.

## 3. Create the App Private Key

After creating the GitHub App:

**GitHub App → General settings → Private keys → Generate a private key**

GitHub downloads a `.pem` file similar to:

```text
rs-repo-bootstrap.<date>.private-key.pem
```

### Security

The private key is a **secret** and must **never be committed to Git**.

Store the complete PEM content, including:

```text
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
```

and:

```text
-----END RSA PRIVATE KEY-----
```

as a GitHub Environment Secret.

For example:

```text
TF_VAR_github_app_private_key
```

## 4. Find the GitHub App ID

Open the GitHub App configuration page:

```text
https://github.com/settings/apps/<APP-NAME>
```

For an organization-owned App, navigate through:

```text
Organization
  → Settings
  → Developer settings
  → GitHub Apps
  → <App Name>
```

The **App ID** is displayed in the App's settings.

Example:

```text
App ID: 5094683
```

The App ID is **not a secret**.

## 5. Install the GitHub App

From the GitHub App configuration page, select:

**Install App**

Select the target organization:

```text
ArcticStorm02
```

When prompted for repository access, choose either:

* **All repositories**, or
* **Only select repositories**

For a least-privilege setup, **Only select repositories** should be used when the automation does not require access to every repository.

GitHub requires the App to be installed on the organization before it can access organization/repository resources.

## 6. Find the Installation ID

After installing the App on the organization, open:

```text
Organization
  → Settings
  → Developer settings
  → GitHub Apps
  → Installed GitHub Apps
```

Open the installation details.

The installation URL contains the **Installation ID**.

Example:

```text
https://github.com/organizations/ArcticStorm02/settings/installations/165387746
```

Therefore:

```text
Installation ID = 165387746
```

### Important distinction

These are three different identifiers:

| Value           |        Example | Secret? |
| --------------- | -------------: | ------- |
| GitHub App ID   |      `5094683` | No      |
| Installation ID |    `165387746` | No      |
| App Private Key | `.pem` content | **Yes** |

## 7. Configure Terraform

The Terraform GitHub provider can use the App ID, Installation ID, and private key for App authentication:

```hcl
provider "github" {
  owner = var.org_details.org_name

  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_private_key
  }
}
```

The corresponding Terraform variables are:

```hcl
variable "github_app_id" {
  type        = string
  description = "GitHub App ID."
}

variable "github_app_installation_id" {
  type        = string
  description = "GitHub App Installation ID."
}

variable "github_app_private_key" {
  type        = string
  sensitive   = true
  description = "GitHub App private key in PEM format."
}
```

## 8. GitHub Actions Configuration

The App ID and Installation ID can be stored as GitHub Environment Variables:

```text
TF_VAR_github_app_id
TF_VAR_github_app_installation_id
```

The private key must be stored as a GitHub Environment Secret:

```text
TF_VAR_github_app_private_key
```

Terraform automatically maps environment variables beginning with `TF_VAR_` to Terraform input variables with the corresponding name.

Example:

```yaml
env:
  TF_VAR_github_app_id: ${{ vars.TF_VAR_github_app_id }}
  TF_VAR_github_app_installation_id: ${{ vars.TF_VAR_github_app_installation_id }}
  TF_VAR_github_app_private_key: ${{ secrets.TF_VAR_github_app_private_key }}
```

This keeps the GitHub App credentials out of the Terraform source code and allows the same Terraform module to be used across environments.

## 9. Reference Configuration

The final Terraform provider configuration should remain simple:

```hcl
provider "github" {
  owner = var.org_details.org_name

  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_private_key
  }
}
```

Do **not** keep local private-key paths, hard-coded App IDs, Installation IDs, or alternative provider configurations commented out in the Terraform source.

The credentials should be supplied through Terraform variables and GitHub Actions Environment Variables/Secrets.
