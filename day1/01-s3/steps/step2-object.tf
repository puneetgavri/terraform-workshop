# Upload a file into the bucket.
resource "aws_s3_object" "hello" {
  bucket  = aws_s3_bucket.product_images.id
  key     = "hello.txt"
  content = "Hello from ShopFast!"
}
