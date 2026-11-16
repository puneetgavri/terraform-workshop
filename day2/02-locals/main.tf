variable "environment" {
  type    = string
  default = "dev"
}

# Compute names and tags once, reuse them everywhere.
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
