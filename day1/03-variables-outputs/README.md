# Day 1 · 03 — Variables and outputs

**Story:** ShopFast now needs the same setup for test and dev. Copy-pasting `main.tf` per environment won't scale, so it's time for variables.

## Steps

1. **Apply with defaults.** `terraform init && terraform apply`. `environment` defaults to `"test"` (see `variables.tf`), so the bucket is `shopfast-test-assets`.
2. **Use tfvars.** Add this line to `terraform.tfvars`:
   ```hcl
   environment = "dev"
   ```
   Run `terraform plan`: the bucket name changes, so it's replaced. Apply.
3. **Override on the command line.** `-var` beats `terraform.tfvars`:
   ```bash
   terraform plan -var="environment=prod"
   ```
   Just plan, don't apply.
4. **Add outputs.**
   ```bash
   cp steps/step4-outputs.tf .
   terraform apply
   terraform output
   terraform output -raw bucket_name
   ```
5. **Clean up.** `terraform destroy`

**Precedence (lowest → highest):** variable default → `terraform.tfvars` → `*.auto.tfvars` → `-var-file` / `-var`.
