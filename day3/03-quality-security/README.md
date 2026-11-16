# Day 3 · 03 — Code quality and security

**Story:** ShopFast is about to store customer data, and an auditor is coming. The current code works, but it's messy, has lint issues, and the bucket is wide open.

## Steps

1. **Format and validate.**
   ```bash
   terraform init
   terraform fmt -check -diff     # shows what's wrong (exit code 3)
   terraform fmt                  # fixes it
   terraform validate
   ```
2. **Lint.**
   ```bash
   tflint --init
   tflint
   ```
   tflint reports two problems in `main.tf`. Fix both, then rerun `tflint` until it's clean:
   - `variable "owner"` is never used and has no type: delete it.
   - `Environment = "${var.environment}"` uses deprecated interpolation: change it to `Environment = var.environment`.
3. **Security scan.**
   ```bash
   checkov -d . --skip-path steps
   ```
   (`--skip-path steps` stops checkov from scanning the step files you haven't copied in yet.)

   Note the failures: no public access block (`CKV2_AWS_6`), no KMS encryption (`CKV_AWS_145`), no versioning (`CKV_AWS_21`). Add the fixes and scan again:
   ```bash
   cp steps/step3-security.tf .
   checkov -d . --skip-path steps
   ```
   Those three now pass. Four checks still fail: access logging, cross-region replication, event notifications and lifecycle. In a real project you'd fix them, or skip them with a reason:
   ```hcl
   resource "aws_s3_bucket" "customer_data" {
     #checkov:skip=CKV_AWS_144:Single-region workshop
     ...
   }
   ```
4. **Apply and clean up.** `terraform apply`, then `terraform destroy`.
