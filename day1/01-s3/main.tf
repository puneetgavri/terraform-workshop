# ShopFast's first bucket, for product images.
resource "aws_s3_bucket" "product_images" {
  bucket = "shopfast-product-images-v2"

  tags = {
    Project     = "ShopFast"
    Environment = "staging"
    Team        = "catalog"
  }
}
