# Day 3 · 01 — Import

**Story:** Before ShopFast adopted Terraform, the marketing team created `shopfast-marketing` by hand. It's in production and can't be deleted and recreated. Bring it under Terraform's control.

## Steps

1. **Create the "legacy" bucket.**
   ```bash
   ./setup.sh
   terraform init
   terraform plan          # nothing - Terraform doesn't know the bucket exists
   ```
2. **Import it.** Add the `import` block, then let Terraform write the resource config for you:
   ```bash
   cp steps/step2-import.tf .
   terraform plan -generate-config-out=imported.tf
   ```
   Open `imported.tf` and review it (tidy it up if you like — remove `null` attributes).
3. **Apply the import.**
   ```bash
   terraform apply         # "1 to import, 0 to add, 0 to change, 0 to destroy"
   terraform state list
   ```
4. **Plan again.** `terraform plan` → *No changes*. The bucket is now managed by Terraform. You can now delete `step2-import.tf`, because the import block has done its job.
5. **Clean up.** `terraform destroy` (add `force_destroy = true` to the bucket in `imported.tf` and apply first if it complains the bucket isn't empty), then `rm imported.tf`.
