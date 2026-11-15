terraform {
  required_version = ">= 1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

# STEP 2: tflint flags this variable - delete it (it's never used and has no type)

variable "environment" {
  type    = string
  default = "prod"
}

# STEP 1: this bucket works, but it's messy and insecure.
resource "aws_s3_bucket" "customer_data" {
  bucket = "shopfast-customer-data-${var.environment}"
  tags = {
    # STEP 2: tflint flags this interpolation - change it to: Environment = var.environment
    Environment = var.environment
    Project     = "ShopFast"
  }
}

# STEP 3: uncomment this block (block all public access)
resource "aws_s3_bucket_public_access_block" "customer_data" {
  bucket                  = aws_s3_bucket.customer_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "customer_data" {
  bucket = aws_s3_bucket.customer_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "customer_data" {
  bucket = aws_s3_bucket.customer_data.id

  versioning_configuration {
    status = "Enabled"
  }
}
