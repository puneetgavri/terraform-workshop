# No hard-coded names: values come from variables.tf and terraform.tfvars.
resource "aws_s3_bucket" "assets" {
  bucket = "${var.bucket_prefix}-${var.environment}-assets"

  tags = merge(var.tags, {
    Environment = var.environment
  })
}
