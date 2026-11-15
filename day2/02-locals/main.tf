variable "environment" {
  type    = string
  default = "dev"
}

# STEP 1: compute names and tags once, reuse them everywhere.
locals {
  name_prefix = "shopfast-${var.environment}"

  common_tags = {
    Project     = "ShopFast"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket" "invoices" {
  bucket = "${local.name_prefix}-invoices"
  tags   = local.common_tags
}

# STEP 2: uncomment this block (versioning only in prod, using a conditional)
resource "aws_s3_bucket_versioning" "invoices" {
  count  = var.environment == "prod" ? 1 : 0
  bucket = aws_s3_bucket.invoices.id

  versioning_configuration {
    status = "Enabled"
  }
}
