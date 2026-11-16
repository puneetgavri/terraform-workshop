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

variable "environment" {
  type    = string
  default = "prod"
}

resource "aws_s3_bucket" "customer_data" {
  bucket = "shopfast-customer-data-${var.environment}"
  tags = {
    Environment = var.environment
    Project     = "ShopFast"
  }
}
