# A bucket and a file. Apply, then explore the state.
resource "aws_s3_bucket" "orders_export" {
  bucket = "shopfast-orders-export"

  tags = {
    Project = "ShopFast"
  }
}

resource "aws_s3_object" "readme" {
  bucket  = aws_s3_bucket.orders_export.id
  key     = "README.txt"
  content = "Nightly order exports land here."
}
