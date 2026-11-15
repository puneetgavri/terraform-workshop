# STEP 1: nothing here yet. Run ./setup.sh to create a bucket outside Terraform.

# STEP 2: uncomment this block, then run: terraform plan -generate-config-out=imported.tf
import {
  to = aws_s3_bucket.marketing
  id = "shopfast-marketing"
}
