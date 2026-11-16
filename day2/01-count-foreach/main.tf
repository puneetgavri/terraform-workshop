# The same buckets with for_each. Buckets are tracked by key, not by position.
resource "aws_s3_bucket" "category" {
  for_each = toset(["electronics", "books"])
  bucket   = "shopfast-${each.key}"
}
