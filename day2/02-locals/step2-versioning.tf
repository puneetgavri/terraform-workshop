# Versioning only in prod, using a conditional count.
resource "aws_s3_bucket_versioning" "invoices" {
  count  = var.environment == "prod" ? 1 : 0
  bucket = aws_s3_bucket.invoices.id

  versioning_configuration {
    status = "Enabled"
  }
}
