# Day 2 · 04 — Remote state and locking

**Story:** ShopFast now has three engineers. Two of them ran `apply` at the same time from their laptops, each with their own `terraform.tfstate`. Chaos. Time to share state in S3 — with locking.

## Steps

1. **Local state.** `terraform init && terraform apply`. State lives in `./terraform.tfstate`.
2. **Create the state bucket** (outside Terraform — it must exist before the backend can use it):
   ```bash
   aws s3 mb s3://shopfast-tf-state
   aws s3api put-bucket-versioning --bucket shopfast-tf-state \
     --versioning-configuration Status=Enabled
   ```
3. **Move state to S3.**
   ```bash
   cp steps/step3-backend.tf backend.tf
   terraform init -migrate-state     # answer "yes"
   aws s3 ls s3://shopfast-tf-state --recursive
   terraform plan                    # no changes - same state, new home
   ```
   The local `terraform.tfstate` is now empty; the real state is in S3.
4. **Locking demo (two terminals).** `use_lockfile = true` makes Terraform write a `.tflock` file next to the state in S3.
   - **Terminal 1:** `terraform apply` — **don't** answer the prompt yet.
   - **Terminal 2:** `terraform plan` — fails with *Error acquiring the state lock*.
   - Peek at the lock: `aws s3 ls s3://shopfast-tf-state --recursive`
   - Answer `no` in Terminal 1; the lock is released and Terminal 2 works again.
   - If a lock ever gets stuck: `terraform force-unlock <LOCK_ID>`
5. **Clean up.** `terraform destroy`, then (optional) `aws s3 rb s3://shopfast-tf-state --force`.

> Floci's data resets when the Codespace restarts. If the state bucket is gone, recreate it (step 2) or delete `backend.tf` and run `terraform init -migrate-state` to go back to local state.
