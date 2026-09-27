### Terraform Environment Variables

Terraform automatically maps environment variables prefixed with `TF_VAR_` to Terraform input variables.

For example:

`variable "github_app_id"` → `TF_VAR_github_app_id`

This allows GitHub Actions to provide Terraform variables without passing them explicitly through `-var` arguments.

```yaml
env:
  TF_VAR_github_app_id: ${{ vars.TF_VAR_github_app_id }}
  TF_VAR_github_app_private_key: ${{ secrets.TF_VAR_github_app_private_key }}