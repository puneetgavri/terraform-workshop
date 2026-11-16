# The bucket name includes the current workspace.
resource "aws_s3_bucket" "site" {
  bucket = "shopfast-${terraform.workspace}-site"

  tags = {
    Project   = "ShopFast"
    Workspace = terraform.workspace
  }
}

output "bucket_name" {
  value = aws_s3_bucket.site.bucket
}
