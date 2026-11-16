# Day 3 · 02 — Secrets

**Story:** ShopFast is adding a real orders database. The password must not end up in Git, in CI logs, or on a screen share.

## Steps

1. **Pass the secret via the environment** (never in `terraform.tfvars` committed to Git):
   ```bash
   export TF_VAR_db_password='S3cr3t-Passw0rd!'
   terraform init
   terraform plan          # value shows as (sensitive value)
   terraform apply
   aws ssm get-parameter --name /shopfast/prod/db_password --with-decryption
   ```
2. **Sensitive outputs.** Copy in the output, remove `sensitive = true` from it and run `terraform plan`: Terraform refuses. Put it back, apply, then:
   ```bash
   cp steps/step2-output.tf .
   terraform output                 # db_password = <sensitive>
   terraform output -raw db_password  # explicit request: shown
   ```
3. **The catch: state is plain text.**
   ```bash
   grep -n "S3cr3t" terraform.tfstate
   ```
   `sensitive` only hides values from CLI output. Anyone who can read the state can read the secret — so protect the state (encrypted remote backend, tight access), or use write-only/ephemeral attributes or let AWS generate the secret (e.g. RDS `manage_master_user_password`).
4. **Clean up.** `terraform destroy` and `unset TF_VAR_db_password`
