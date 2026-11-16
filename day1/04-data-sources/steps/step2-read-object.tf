# Upload a file, then read it back with a data source.
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
