# STEP 1: ShopFast's first bucket, for product images.
resource "aws_s3_bucket" "product_images" {
  # STEP 4: change the bucket name, e.g. to "shopfast-product-images-v2",
  #         then run plan. A bucket name can't be changed in place, so
  #         Terraform must destroy and recreate it ("forces replacement").
  bucket = "shopfast-product-images-v2"

  tags = {
    Project = "ShopFast"
    # STEP 3: change "dev" to "staging", then run plan (an in-place update ~)
    Environment = "staging"
    Team        = "catalog"
  }
}

# STEP 2: uncomment this block
resource "aws_s3_object" "hello" {
  bucket  = aws_s3_bucket.product_images.id
  key     = "hello.txt"
  content = "Hello from ShopFast!"
}
