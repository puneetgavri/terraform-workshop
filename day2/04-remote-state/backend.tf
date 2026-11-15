# STEP 3: uncomment this block, then run: terraform init -migrate-state
terraform {
  backend "s3" {
    bucket       = "shopfast-tf-state"
    key          = "day2/remote-state/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true

    endpoints = {
      s3 = "http://localhost:4566"
    }
    use_path_style              = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
  }
}
