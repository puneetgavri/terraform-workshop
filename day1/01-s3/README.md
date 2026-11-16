# Day 1 · 01 — Your first S3 bucket

**Story:** ShopFast is a two-person startup selling gadgets online. They need somewhere to store product images, and they want it written as code from day one.

## Steps

1. **Create the bucket.** `main.tf` already has the bucket.
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
   Find the bucket in the Floci UI, or run `aws s3 ls`.
2. **Upload a file.**
   ```bash
   cp steps/step2-object.tf .
   terraform apply
   aws s3 ls s3://shopfast-product-images
   ```
   Only one resource is added; the bucket is untouched.
3. **Change a tag.** In `main.tf`, change `Environment = "dev"` to `Environment = "staging"`. Run `terraform plan`: `~` means an in-place update. Apply.
4. **Rename the bucket.** In `main.tf`, change the bucket name to `"shopfast-product-images-v2"`. Run `terraform plan`: `-/+` and *forces replacement*. A bucket can't be renamed, so Terraform destroys and recreates it, and the object with it. Apply.
5. **Clean up.** `terraform destroy`
