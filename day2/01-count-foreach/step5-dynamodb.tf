# for_each over a map: one table per entry (table name => hash key).
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
