# Read facts about the account and region instead of hard-coding them.
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "logs" {
  bucket = "shopfast-logs-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
}

output "bucket_name" {
  value = aws_s3_bucket.logs.bucket
}
