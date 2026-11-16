# Day 2 · 03 — Modules

**Story:** ShopFast's storage pattern (bucket + versioning + tags) is copy-pasted everywhere. Package it once as a module and reuse it.

## Layout

```
03-modules/
├── main.tf               # root: calls the module for dev
├── steps/
│   └── step2-prod.tf     # second module call, for prod
└── modules/storage/      # the module: bucket, versioning, tags
    ├── main.tf
    ├── variables.tf      # inputs: name, environment, tags
    └── outputs.tf        # outputs: bucket_name, bucket_arn
```

## Steps

1. **Dev.** `terraform init && terraform apply`. `terraform state list` shows `module.storage_dev.aws_s3_bucket.this`.
2. **Prod.** A new module call needs `init` again:
   ```bash
   cp steps/step2-prod.tf .
   terraform init
   terraform apply
   ```
3. **Clean up.** `terraform destroy`
