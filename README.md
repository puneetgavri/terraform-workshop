# ShopFast Terraform Workshop

A 3-day hands-on Terraform workshop on AWS — with **no AWS account needed**. Everything runs in GitHub Codespaces against [Floci](https://hub.docker.com/r/hectorvent/floci), a local AWS emulator.

**The story:** you're the platform team at *ShopFast*, an online shop that starts as a two-person startup and grows into a company with many environments, teammates, auditors and a CI pipeline. Each topic is one step in that journey.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/puneetgavri/terraform-workshop)

## Getting started

1. Click **Use this template → Create a new repository** (or use the badge above to open this repo directly).
2. In your repo: **Code → Codespaces → Create codespace on main**.
3. Wait for setup to finish. It installs Terraform, the AWS CLI, tflint and checkov, then starts:
   - **Floci** (AWS emulator) on port `4566`
   - **Floci UI** on port `4500` — opens in your browser; also in the **PORTS** tab
4. Check it works:
   ```bash
   terraform version
   aws s3 ls        # empty output, no error = good
   ```

AWS credentials (`test`/`test`), region and endpoint are preset as environment variables, so the provider blocks contain no keys or endpoints.

## Agenda

| Day | Folder | Topic |
|-----|--------|-------|
| 1 | [`day1/01-s3`](day1/01-s3) | First resources: S3 bucket, object, update vs replace |
| 1 | [`day1/02-state`](day1/02-state) | State: list, show, refresh |
| 1 | [`day1/03-variables-outputs`](day1/03-variables-outputs) | Variables, tfvars, `-var`, outputs |
| 1 | [`day1/04-data-sources`](day1/04-data-sources) | Data sources |
| 2 | [`day2/01-count-foreach`](day2/01-count-foreach) | `count` vs `for_each` |
| 2 | [`day2/02-locals`](day2/02-locals) | Locals and conditionals |
| 2 | [`day2/03-modules`](day2/03-modules) | Writing and calling modules |
| 2 | [`day2/04-remote-state`](day2/04-remote-state) | S3 backend, state migration, locking |
| 2 | [`day2/05-workspaces`](day2/05-workspaces) | Workspaces |
| 2 | [`day2/06-drift`](day2/06-drift) | Detecting and fixing drift |
| 3 | [`day3/01-import`](day3/01-import) | Importing existing resources |
| 3 | [`day3/02-secrets`](day3/02-secrets) | Sensitive values and state |
| 3 | [`day3/03-quality-security`](day3/03-quality-security) | fmt, validate, tflint, checkov |
| 3 | [`day3/04-ci`](day3/04-ci) | GitHub Actions pipeline |

## How each topic works

Each folder's `main.tf` holds **Step 1** only. Later steps are ready-made files in a `steps/` subfolder:

```
day1/01-s3/
├── main.tf              # Step 1
├── providers.tf
├── README.md            # the story and every step
└── steps/
    └── step2-object.tf  # copy in when you reach Step 2
```

Terraform only reads `.tf` files in the folder you run it from, so `steps/` is ignored until you copy a file in:

```bash
cp steps/step2-object.tf .
```

Steps that change a single value (a tag, a name, a list item) are described in the README; you make that edit by hand.

Standard loop:

```bash
cd day1/01-s3                 # 1. go to the topic folder
terraform init                # 2. once per folder
terraform plan                # 3. see what will change
terraform apply               # 4. make it so
cp steps/step2-object.tf .    # 5. add the next step (or make the README's edit)
terraform plan && terraform apply
terraform destroy             # 6. always clean up at the end of the topic
```

> The Terraform extension may show red underlines in `steps/` files (for example, an unknown bucket reference). That's expected: those files only make sense once copied next to `main.tf`.

Stuck? The **`solutions`** branch has every step already applied:

```bash
git diff main solutions -- day1/01-s3
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `docker ps` shows no containers, `connection refused` on `localhost:4566`, or Floci UI not loading | Restart the emulator: `bash .devcontainer/start-emulator.sh` |
| Resources/buckets "disappeared" | Floci keeps data **in memory** — it resets whenever the container or Codespace restarts. Delete the local state (`rm -f terraform.tfstate*`) and apply again. |
| `day2/04-remote-state` fails to init | The `shopfast-tf-state` bucket was wiped by a restart. Recreate it (see that README). |
| `BucketAlreadyExists` | A previous topic wasn't destroyed. Run `terraform destroy` there, or `aws s3 rb s3://<name> --force`. |
| `tflint` / `checkov` not found | Rerun the setup: `bash .devcontainer/install-tools.sh` |
| Check the containers | `docker ps` and `docker logs floci` |
