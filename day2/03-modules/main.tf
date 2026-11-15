# STEP 1: use the storage module for dev.
module "storage_dev" {
  source = "./modules/storage"

  name        = "shopfast-dev-media"
  environment = "dev"
  tags        = { Project = "ShopFast" }
}

output "dev_bucket" {
  value = module.storage_dev.bucket_name
}

# STEP 2: uncomment this block (same module, second environment)
module "storage_prod" {
  source = "./modules/storage"

  name        = "shopfast-prod-media"
  environment = "prod"
  tags        = { Project = "ShopFast" }
}

output "prod_bucket" {
  value = module.storage_prod.bucket_name
}
