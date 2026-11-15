# STEP 1: one bucket per product category, using count.
variable "categories" {
  type = list(string)
  # STEP 2: remove "toys" (the middle item), then run plan.
  #         count tracks buckets by position, so "books" moves from [2] to [1]
  #         and Terraform wants to replace buckets that didn't change!
  default = ["electronics", "books"]
}

# STEP 3: run terraform destroy, comment out this count block, then uncomment the for_each block below
# resource "aws_s3_bucket" "category" {
#   count  = length(var.categories)
#   bucket = "shopfast-${var.categories[count.index]}"
# }

# STEP 3: uncomment this block (for_each tracks buckets by key, not position)
resource "aws_s3_bucket" "category_set" {
  # STEP 4: remove "toys" from the set, then run plan. Only that bucket is destroyed.
  for_each = toset(["electronics", "books"])
  bucket   = "shopfast-${each.key}"
}

# STEP 5: uncomment this block (for_each over a map: one table per entry)
variable "tables" {
  type = map(string)
  default = {
    orders    = "id"
    customers = "id"
  }
}

resource "aws_dynamodb_table" "this" {
  for_each     = var.tables
  name         = "shopfast-${each.key}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = each.value

  attribute {
    name = each.value
    type = "S"
  }
}
