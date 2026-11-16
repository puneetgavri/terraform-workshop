# Day 2 · 01 — count and for_each

**Story:** ShopFast now sells electronics, toys and books. Each category gets its own bucket, and soon the business needs database tables too.

## Steps

1. **count.** `terraform init && terraform apply`. Three buckets from a list. Run `terraform state list`: they're `category[0]`, `category[1]`, `category[2]`.
2. **The count trap.** In `main.tf`, remove `"toys"` (the middle item) from the list and run `terraform plan`. Terraform wants to replace `category[1]` (it's now `books`) and destroy `category[2]`. The indexes shifted, so a bucket that didn't change gets replaced. Don't apply.
3. **Switch to for_each.** Destroy first, because the new version creates buckets with the same names:
   ```bash
   terraform destroy
   cp steps/step3-main.tf main.tf     # replaces main.tf
   terraform apply
   terraform state list               # aws_s3_bucket.category["toys"] ...
   ```
4. **Remove the middle item again.** In `main.tf`, remove `"toys"` from the set and run `terraform plan`. Only `["toys"]` is destroyed. Apply.
5. **for_each over a map.** DynamoDB tables `orders` and `customers`:
   ```bash
   cp steps/step5-dynamodb.tf .
   terraform apply
   aws dynamodb list-tables
   ```
6. **Clean up.** `terraform destroy`

> Rule of thumb: use `count` for "N identical things" or on/off switches, and `for_each` for anything with a name.
