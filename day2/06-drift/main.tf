# The "official" configuration of ShopFast's checkout assets.
resource "aws_s3_bucket" "checkout" {
  bucket = "shopfast-checkout-assets"

  tags = {
    Project     = "ShopFast"
    Environment = "prod"
    CostCenter  = "checkout"
  }
}

resource "aws_s3_object" "banner" {
  bucket  = aws_s3_bucket.checkout.id
  key     = "banner.txt"
  content = "Free shipping on orders over $50!"
}
