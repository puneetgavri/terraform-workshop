# Day 2 · 02 — Locals and conditionals

**Story:** ShopFast's tags are inconsistent: some say `Env`, some `environment`, some nothing. Finance can't tell what costs what. Fix it once with `locals`.

## Steps

1. **Locals.** `terraform init && terraform apply`. The name prefix and tags are computed in one `locals` block.
2. **Conditional versioning.** Versioning is enabled only when `environment == "prod"`.
   ```bash
   cp steps/step2-versioning.tf .
   terraform plan                          # dev: no versioning resource
   terraform plan -var="environment=prod"  # prod: versioning is added
   terraform apply                         # apply the dev version
   ```
3. **Explore in the console.**
   ```bash
   terraform console
   > local.common_tags
   > local.name_prefix
   ```
4. **Clean up.** `terraform destroy`
