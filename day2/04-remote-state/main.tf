# Ordinary resources. State is stored locally in terraform.tfstate.
resource "aws_s3_bucket" "payments" {
  bucket = "shopfast-payments"

  tags = {
    Project = "ShopFast"
  }
}

resource "aws_dynamodb_table" "payments" {
  name         = "shopfast-payments"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
