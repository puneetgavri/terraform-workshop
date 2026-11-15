# STEP 1: read facts about the account and region instead of hard-coding them.
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "logs" {
  bucket = "shopfast-logs-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
}

output "bucket_name" {
  value = aws_s3_bucket.logs.bucket
}

# STEP 2: uncomment this block (upload a file, then read it back with a data source)
resource "aws_s3_object" "config" {
  bucket       = aws_s3_bucket.logs.id
  key          = "config.txt"
  content      = "log_level=info"
  content_type = "text/plain"
}

data "aws_s3_object" "config" {
  bucket = aws_s3_bucket.logs.id
  key    = aws_s3_object.config.key
}

output "config_content" {
  value = data.aws_s3_object.config.body
}
